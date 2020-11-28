Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 205002C71B8
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 23:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390527AbgK1VvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 16:51:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42727 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729914AbgK1Scn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Nov 2020 13:32:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606588276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WNoWdXu5wxWAzbrekOooRXMDABHNzLMewmarGmJ9AlU=;
        b=iKIZfQBLyAgFQJD30LLI7rbKqDvMPDsnV3Yzc8nM7uDynWbpts52FDANUmkpf7jkYraBBp
        hTP+tOoxFrE4FmKM4+Jtg8MaoiLRaSTo173v/wMZAtdAO6NWq/s9wTlUKmmAL+NKdiYhxC
        gxFnuqib9CNKxa4tPzbKC9/6Fc/E+wU=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-d_g_fqREPW-gewAw5RFzdQ-1; Sat, 28 Nov 2020 11:30:44 -0500
X-MC-Unique: d_g_fqREPW-gewAw5RFzdQ-1
Received: by mail-qt1-f197.google.com with SMTP id n95so5234809qte.16
        for <linux-kernel@vger.kernel.org>; Sat, 28 Nov 2020 08:30:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=WNoWdXu5wxWAzbrekOooRXMDABHNzLMewmarGmJ9AlU=;
        b=JUtEe82nqXh+MzddhBIQRGSp41YIaiCqzaMrwNgNl5rdycr4gcHIr2l13IFQhMInBc
         wZb4/MlYPspM83raK4KPjLws1XuCqZS/EVCcXZg6fxccVe1hItMs3HYhxNcuj7kKCLDr
         7s+7h3thyZgoX6sjuFPCP7ZpSnIKSQQVSKVkbLOpCvTgFz4ADH5TSnfQ0TO7lkdYw+MT
         HO5jSbXxJNYOqWrbcSS3+CCbtfc5sP8N272ptKVCOmR4N0T8dhqS1AbKaHgAdhEZlWu2
         0oyPB0yLkEebUoLn8RgicGpHe+3OIu5fhTB/hsp4iT0TblCBR1YvCfwpJLdNbrlY5UUZ
         ULLQ==
X-Gm-Message-State: AOAM532gS4D9bMbVQpbxmwhi9bVtUJlZFrKXDKLkQcQO6Jcy1VSqCM6K
        Wy9HkzXlnWXYsmlA8KhSSQwrUmPJJFVMux9IkwtHeuzQWMP7locT7qNu+TAo4byAWDofyr9Cmcc
        5ecaKIRCTbi1CeWIIcC28tT5FS3RGUZIGoxDxjON3yzvz59pMdDCIx1HMqbJKnAJMRg1QRKw=
X-Received: by 2002:ac8:74c7:: with SMTP id j7mr13820844qtr.179.1606581043953;
        Sat, 28 Nov 2020 08:30:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwrfs1uTLYSwFv5B6JkXE1givPzuUzyls/nA1NWSLVuLtoWPR0vYcctAo4j23+2a6FrX5hIBg==
X-Received: by 2002:ac8:74c7:: with SMTP id j7mr13820814qtr.179.1606581043639;
        Sat, 28 Nov 2020 08:30:43 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id x19sm9596951qtr.65.2020.11.28.08.30.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Nov 2020 08:30:43 -0800 (PST)
Subject: Re: [PATCH] MAINTAINERS add D: tag for subsystem commit prefix
To:     Joe Perches <joe@perches.com>, apw@canonical.com,
        nickhu@andestech.com, green.hu@gmail.com, deanbo422@gmail.com
Cc:     linux-kernel@vger.kernel.org
References: <20201127214316.3045640-1-trix@redhat.com>
 <a4e796f8c0bfdb2c0a2816fa706d13cc0ae06d40.camel@perches.com>
 <f96ff56c-7c39-2fed-dd8b-11971f8965bf@redhat.com>
 <6e9917257cfd6774066446014051d39b784ba497.camel@perches.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <8a48dbc8-59cc-5fff-e9ea-e68ffb9e698a@redhat.com>
Date:   Sat, 28 Nov 2020 08:30:41 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <6e9917257cfd6774066446014051d39b784ba497.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/28/20 8:00 AM, Joe Perches wrote:
> On Sat, 2020-11-28 at 07:36 -0800, Tom Rix wrote:
>> On 11/27/20 2:10 PM, Joe Perches wrote:
> []
>>> I think an exception mechanism would be better than a specific
>>> mechanism added to various entries.
>> Can you give an example of what you mean ?
> Inherit the parent prefix then add the basename(dirname) as a default.
>
> For instance, changes to any subsystem of drivers/staging starts as
> "staging: " and with "$basename(path): " appended.

Ah, this is quite a bit different.

As far as I can tell there is no default.

MAINTAINERS would only have the exceptions, obviously needing drivers/foo to be 'foo:'

Without the full prefix, the user would be need to use get_maintainer.pl to figure it out.

Are the ""'s in the D value necessary ?

> So the MAINTAINERS entry for staging could be:
>
> STAGING SUBSYSTEM
> M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> L:	devel@driverdev.osuosl.org
> S:	Supported
> T:	git git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
> D:	"staging: "
> F:	drivers/staging/
>
> Any specified D: use would override the generic form.
>
> And generic ARM changes could use the same mechanism with:
>
> ARM PORT
> M:	Russell King <linux@armlinux.org.uk>
> L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> S:	Odd Fixes
> W:	http://www.armlinux.org.uk/
> T:	git git://git.armlinux.org.uk/~rmk/linux-arm.git
> D:	"ARM: "
> F:	arch/arm/
> X:	arch/arm/boot/dts/
>
> And media likewise:
>
> MEDIA INPUT INFRASTRUCTURE (V4L/DVB)
> M:	Mauro Carvalho Chehab <mchehab@kernel.org>
> L:	linux-media@vger.kernel.org
> S:	Maintained
> W:	https://linuxtv.org
> Q:	http://patchwork.kernel.org/project/linux-media/list/
> T:	git git://linuxtv.org/media_tree.git
> D:	"media: "
> F:	Documentation/admin-guide/media/
> F:	Documentation/devicetree/bindings/media/
> F:	Documentation/driver-api/media/
> F:	Documentation/userspace-api/media/
> F:	drivers/media/
> F:	drivers/staging/media/
> F:	include/linux/platform_data/media/
> F:	include/media/
> F:	include/uapi/linux/dvb/
> F:	include/uapi/linux/ivtv*
> F:	include/uapi/linux/media.h
> F:	include/uapi/linux/meye.h
> F:	include/uapi/linux/uvcvideo.h
> F:	include/uapi/linux/v4l2-*
> F:	include/uapi/linux/videodev2.h
>
> etc...
>
>>>>  # check MAINTAINERS entries for the right ordering too
>>>> -			my $preferred_order = 'MRLSWQBCPTFXNK';
>>>> +			my $preferred_order = 'MRLSWQBCPTFXNKD';
>>>>  			if ($rawline =~ /^\+[A-Z]:/ &&
>>>>  			    $prevrawline =~ /^[\+ ][A-Z]:/) {
>>>>  				$rawline =~ /^\+([A-Z]):\s*(.*)/;
>>> I'd prefer to keep the file and keyword list last.
>>>
>> So change to
>>
>> my $preferred_order = 'MRLSWQBCPTDFXNK'; 
>>
>> ?
> Right.  And update the preferred_order in scripts/parse-maintainers.pl too.
>
>
>

