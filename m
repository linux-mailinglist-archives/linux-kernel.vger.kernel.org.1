Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0933E2ED5C0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 18:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728720AbhAGRgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 12:36:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbhAGRgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 12:36:31 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9137AC0612F4;
        Thu,  7 Jan 2021 09:35:51 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id q25so7014566otn.10;
        Thu, 07 Jan 2021 09:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bWGtKVWhJ47oNq9MDvFxm15l6IGCufrstxRiRqP5EBU=;
        b=EHVzKj/2Y8S9MafbS3dTY7hPkNAfTOV7DA74Cz56l8DQAlZTAWYwtF/Z7KJ0lOE3Gx
         4hFV8hrwFa6RGWDXPv7CNhfq19+6V51naHMnZE38PEnTHB5kyVmSfqbdAZrt2llOKuxg
         5jYJbOQIbca31zYYRjskHNv8hKSFA8fcqKYSy8gqQ1wC7IamlA4vsiPfHLV3HECi2e7P
         FLqL7aSSHVnpHHkO4ZZgl6+mwN8qSNN1kxnX4oivaJfGFWMXiSLvRWQdowHSzIpCAhOy
         f5MM3j1RRTpYlqdSrXCVJiBDsV6CkZGCYRw1ogo99X79BoWWAoPp2qjhItMlm1alkX+s
         25jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=bWGtKVWhJ47oNq9MDvFxm15l6IGCufrstxRiRqP5EBU=;
        b=Ab03R6/nqvOyeiFr9KEavQpHm1nPOc1nCAlM3SIvA0E7StWY/392fOiqptqbXKufkN
         SrN/gTslYh9kFotpLMMl6M6NGTJDI2nTLI3Y1z4AyTZOg+sVHpLS2LcPXLeq1juvKEGj
         Ss460pjrIXOhtWCtr2RKkoCOrgF+H2QsDhvLjX5KN2S5L8GLofsZZ3rU0O9hE1Mwj+hg
         qw24439XiATLmWtGE08V/wQphMJe51DLxMYsipxgi9A4SoMuBUFrRb90ByJ20HHUgCKQ
         c7QCSnCE9aF1iXqWvYKI1e8VaJ8N/LXbKVzp9BcOdloM6EjVtkVe7+Mwbtv6SNnWeBBi
         lDbg==
X-Gm-Message-State: AOAM531FX6NI8XdUNiOMu6FwmtPnOscxz7Mhr4Vqhx841gS0pao40FsS
        D5npt/rH1F51BQXnuqz2waM=
X-Google-Smtp-Source: ABdhPJysLHgYiOhiXmda/5ax+XNTq8lXCnhj2YtQgoN/0nxezCq8pMZdXJlHzCs+FkNkMKZ8QPuOvQ==
X-Received: by 2002:a9d:470f:: with SMTP id a15mr7422886otf.62.1610040950951;
        Thu, 07 Jan 2021 09:35:50 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a22sm1226782otr.75.2021.01.07.09.35.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Jan 2021 09:35:49 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 7 Jan 2021 09:35:48 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-hwmon@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, jdelvare@suse.com,
        "Thoren, Mark" <mark.thoren@analog.com>
Subject: Re: [PATCH v3 3/4] hwmon: (ltc2945): add support for sense resistor
Message-ID: <20210107173548.GA49383@roeck-us.net>
References: <20210107103417.16010-1-alexandru.ardelean@analog.com>
 <20210107103417.16010-4-alexandru.ardelean@analog.com>
 <20210107152538.GC13040@roeck-us.net>
 <CA+U=Dspo0aovB4M76FoUaPpfYN-ZiCkCUc1Am24Mq7VSHRStEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+U=Dspo0aovB4M76FoUaPpfYN-ZiCkCUc1Am24Mq7VSHRStEQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 07, 2021 at 05:44:33PM +0200, Alexandru Ardelean wrote:
> >
> > Note that this patch doesn't compile on 32-bit targets.
> 
> Yeah, my bad.
> I only tested with  make allmodconfig, and that doesn't do a good job
> at providing linker issues.
> 
The problem is the 64-bit divide operation introduced with your patch.
You'd see that if you build allmodconfig with ARCH=i386.

Guenter
