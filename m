Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F24612DA356
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 23:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388348AbgLNWYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 17:24:35 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41641 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388259AbgLNWYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 17:24:22 -0500
Received: by mail-ot1-f66.google.com with SMTP id x13so17438694oto.8;
        Mon, 14 Dec 2020 14:24:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OrNz2hwsU06c3PuGss1E/QBGUDqYdE0+stQHNjTmEF0=;
        b=CZHI9O8vnjPlVgFiHAkyfmhz72O+wr7T5vrRkhigotXyJiA1QcbkZaK972E/HdGAnu
         00jDG573RcknDZ66NKvp0uc3e4S1AOGpzB4UNujJAIHQ3/CMOVJKLoG8Es8Tps7+5nt2
         EGK4j2Ccbzhvw1P4P+bUwAu8AtOYrk3PO9NIWuik4chiebhHQXck9N7IphD/pJAVnBm1
         ZnLl4hdq6fAa/zTFAHdKMB1nmJDk5RTuSD1OzK4HJsgBxiS/KCIwS9h6lgrZBfi1KYQx
         MVnwZU9KJAzQvE4EBEhhl+YSxAu3KvB5MT3SnqExGPN7D/lpl1xn4JMcICNvj9ucF4ml
         SuLg==
X-Gm-Message-State: AOAM530qmYa3ck+FAfXeCu92Qr6kmDJP41oYfUbeS8jgGUBTOtxT2PWX
        fJy2tGEh2YwdQA9N+T8YpWteijyoMQ==
X-Google-Smtp-Source: ABdhPJx3RDNbVhXJglqZJpbqIq6emTGk8OSz3s6JsLztPU1NdhY8gF90dy0DrBxWP4RDzNUek0hvpA==
X-Received: by 2002:a05:6830:30a8:: with SMTP id g8mr15557189ots.291.1607984621501;
        Mon, 14 Dec 2020 14:23:41 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i25sm4652825oto.56.2020.12.14.14.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 14:23:40 -0800 (PST)
Received: (nullmailer pid 2493705 invoked by uid 1000);
        Mon, 14 Dec 2020 22:23:39 -0000
Date:   Mon, 14 Dec 2020 16:23:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vadym Kochan <vadym.kochan@plvision.eu>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH RFC 1/2] Documentation: devicetree: Add property for
 ignoring the dummy bits sent before read transfer
Message-ID: <20201214222339.GA2471866@robh.at.kernel.org>
References: <20201209175708.16252-1-a-govindraju@ti.com>
 <20201209175708.16252-2-a-govindraju@ti.com>
 <20201211033301.GA3581630@robh.at.kernel.org>
 <70d6c152-5d8d-9ad6-ce06-95a9f599c492@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70d6c152-5d8d-9ad6-ce06-95a9f599c492@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 11, 2020 at 08:34:57PM +0530, Aswath Govindraju wrote:
> Hi,
> On 11/12/20 9:03 am, Rob Herring wrote:
> > On Wed, Dec 09, 2020 at 11:27:07PM +0530, Aswath Govindraju wrote:
> >> Dummy zero bits are sent before data during a read transfer. This causes
> >> the data read to be shifted to the right. To fix this send zero bits after
> >> the address during a read transfer.
> >>
> >> Add property to send zero bits after the address during a read transfer.
> > 
> > When is this necessary? Why can't it be implied by the compatible 
> > string which should be specific to the chip model?
> > 
> 
> This is necessary for 93AA46A/B/C, 93LC46A/B/C, 93C46A/B/C eeproms, as
> it can be seen in section 2.7 of [1]. We were not sure if these were the
> only devices supported by the driver(eeprom_93xx46.c). So, in order to
> apply this only to the above listed devices, we thought that it would be
> better to apply this change when required by introducing a DT property.
> 
> May I know how has this case been handled till now ??
> 

No idea. From the at93c46d (which has a compatible string) datasheet it 
looks like it has the same thing.

> If this is required by all the devices then we can drop the property and
> include the zero bit by default.

Looks like you need a combination of compatible strings for the above 
devices and a property for the ORG pin state on the C devices. I assume 
s/w needs to know if x8 or x16?

Rob
