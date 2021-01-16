Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA1522F8D32
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 12:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbhAPL4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 06:56:14 -0500
Received: from mail-wr1-f45.google.com ([209.85.221.45]:43430 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbhAPL4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 06:56:14 -0500
Received: by mail-wr1-f45.google.com with SMTP id y17so11832021wrr.10
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jan 2021 03:55:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5XwVN1hpBP+Q0SAz0ShJP/TBn+ddSeYaUc1STUL+2Jk=;
        b=on7hsWKjC3CThbTRa0IVyA7DkrmGaRzr5+B3xMGXVH0kyHwBRNEkp1daRWVKvXfYGE
         FQeRc4QcUd+7j4XG0YJeQIGbuBDwoCFaF9Wtr5nAVmTT3PRqgbkLm0h6DvjfVquJHQlK
         ZAjp5PnJF61EBoGgrkWcf6hezkUzO193XxUuEEiHDzLhKfHIDhrk2HqVcoY25bQKGsuU
         Zk6R5uQM1rRsGQnN7xYZ7pKn/jTPeCroj8skzp9I6I9FXaIELmFhEKMcsuMM9TD9vh+5
         h2Nxao5Rxrlfbiyqf2q+onbs5ux6qsCVuT4tAMtXOwlGcpCvi4bYN1VxmwJwj3WTBB1L
         iLQA==
X-Gm-Message-State: AOAM530Ywmtz9Zl3RfS/W6bAWxqMMedzqPtUELI9UVohDXWMLBXoy0hH
        +OfOOPrYWWKDK+Xdi7XUKG8=
X-Google-Smtp-Source: ABdhPJy4wP3jYV5CNyxWNRwFEUxT8Zcp6op5Ex39CcZN9Pjp8ZnQHNiDagXEgSNQjMhHf6UBIJ8UIw==
X-Received: by 2002:a5d:6751:: with SMTP id l17mr17588235wrw.73.1610798131737;
        Sat, 16 Jan 2021 03:55:31 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id l1sm19273375wrq.64.2021.01.16.03.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jan 2021 03:55:31 -0800 (PST)
Date:   Sat, 16 Jan 2021 11:55:29 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        tyhicks@linux.microsoft.com, "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Gromm <christian.gromm@microchip.com>
Subject: Re: [PATCH] fTPM: make sure TEE is initialized before fTPM
Message-ID: <20210116115529.oq2k2qpgyawngcqn@liuwe-devbox-debian-v2>
References: <20210116001301.16861-1-wei.liu@kernel.org>
 <b9d69278-9f69-041f-9cef-58584eac435c@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9d69278-9f69-041f-9cef-58584eac435c@infradead.org>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 04:49:57PM -0800, Randy Dunlap wrote:
> Hi,
> 
> On 1/15/21 4:12 PM, Wei Liu wrote:
> > For built-in drivers, the order of initialization function invocation is
> > determined by their link order.
> > 
> > The original code linked TPM drivers before TEE driver when they were
> > both built in. That caused fTPM's initialization to be deferred to a
> > worker thread instead of running on PID 1.
> > 
> > That is problematic because IMA's initialization routine, which runs on
> > PID 1 as a late initcall, needs to have access to the default TPM
> > instance. If fTPM's initialization is deferred, IMA will not be able to
> > get hold of a TPM instance in time.
> > 
> > Fix this by modifying Makefile to make sure TEE is initialized before
> > fTPM when they are both built in.
> > 
> > Signed-off-by: Wei Liu <wei.liu@kernel.org>
> > ---
> >  drivers/Makefile | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/drivers/Makefile b/drivers/Makefile
> > index fd11b9ac4cc3..45ea5ec9d0fd 100644
> > --- a/drivers/Makefile
> > +++ b/drivers/Makefile
> > @@ -180,6 +180,11 @@ obj-$(CONFIG_NVMEM)		+= nvmem/
> >  obj-$(CONFIG_FPGA)		+= fpga/
> >  obj-$(CONFIG_FSI)		+= fsi/
> >  obj-$(CONFIG_TEE)		+= tee/
> > +
> > +# TPM drivers must come after TEE, otherwise fTPM initialization will be
> > +# deferred, which causes IMA to not get a TPM device in time
> > +obj-$(CONFIG_TCG_TPM)		+= char/tpm/
> > +
> >  obj-$(CONFIG_MULTIPLEXER)	+= mux/
> >  obj-$(CONFIG_UNISYS_VISORBUS)	+= visorbus/
> >  obj-$(CONFIG_SIOX)		+= siox/
> > 
> 
> As I suspected and then tested, since you did not remove the other build
> of char/tpm/, this ends up with multiple definition linker errors (below).

Oops, I didn't commit the hunk that removed the line in char/Makefile.

But I will hold off sending out v2 until the following discussion is
settled.

> 
> I would think that instead of depending on Makefile order you should use different
> initcall levels as needed. Depending on Makefile order is what we did 15 years ago.
> 

No, not really. The same trick was used in 2014 (1bacc894c227).

Both TEE and TPM are just drivers. I think they belong to the same level
(at the moment device_initcall).  Looking at the list of levels, I'm not
sure how I can move TEE to a different level.

Out of the seven levels, which one would you suggest I use for which
driver?

Wei.
