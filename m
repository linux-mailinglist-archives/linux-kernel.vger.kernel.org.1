Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A26842BB0B1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 17:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729697AbgKTQhA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 20 Nov 2020 11:37:00 -0500
Received: from mail-ej1-f68.google.com ([209.85.218.68]:45968 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728652AbgKTQhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 11:37:00 -0500
Received: by mail-ej1-f68.google.com with SMTP id lv15so7874043ejb.12
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 08:36:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=S1+8z3yNNlDYJv6/l1QyHGY+01X4guwfwj1g0QgjnEc=;
        b=c0AuT1QqUxAcnj2by3vQPEN3ZPT6J++AhxPj0HyOCe21jGVlfkJdTmv2Wxcpaxoc6s
         LUA94R4v2uD2KdlUGY1lGCpKlWiq+fqWelnO7TO9/dh/ClurE2Hj+b2Ks5jmjwwrKbYH
         MNNcXKiqlDJ9Uwt7DqIpT2hAN+tip9Hdng3vizq3KBHCbnnIvbPxjdx0h6rdmDmh44GI
         C0ReH7e9RMcJ5Ld21REFNGOJFpc2TUU5o6KVk5d2tDReixVhZfKtouyZ2bAA1rp4vY1y
         LOUC28wOWFBi4DqvYfyDYSgTtch8Xcmyc/I+VZAsTcuVpipRocuS9EenxyqMNROusKiw
         s0Dg==
X-Gm-Message-State: AOAM532O+PDfDCWRfiTe2kRWEykg9h6Dx9WWo8OMva9tirgKtM2MSaoB
        Y9Wmf4MOC6E8IZgrmKxKof4=
X-Google-Smtp-Source: ABdhPJxqdMGoZzc6qF5UhhTkPZlu8GkMGDOe+DAxPYzUUAb8Icw7z+1lPxeUche0n6jibG3V8kdEzg==
X-Received: by 2002:a17:906:71d3:: with SMTP id i19mr6287685ejk.187.1605890218153;
        Fri, 20 Nov 2020 08:36:58 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id p20sm1318352ejd.78.2020.11.20.08.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 08:36:57 -0800 (PST)
Date:   Fri, 20 Nov 2020 17:36:55 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Jonghwan Choi <charlie.jh@kakaocorp.com>
Subject: Re: [PATCH 29/38] ASoC: tas2562: skip of_device_id table when
 !CONFIG_OF
Message-ID: <20201120163655.GA519670@kozik-lap>
References: <20201120161653.445521-1-krzk@kernel.org>
 <20201120161653.445521-29-krzk@kernel.org>
 <cacd0acf-708d-0b56-8229-b76690b2d289@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <cacd0acf-708d-0b56-8229-b76690b2d289@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 10:21:56AM -0600, Dan Murphy wrote:
> Hello
> 
> On 11/20/20 10:16 AM, Krzysztof Kozlowski wrote:
> > The driver can match by multiple methods.  Its of_device_id table is
> > referenced via of_match_ptr() so it will be unused for !CONFIG_OF
> > builds:
> > 
> >    sound/soc/codecs/tas2562.c:805:34: warning: ‘tas2562_of_match’ defined but not used [-Wunused-const-variable=]
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > ---
> >   sound/soc/codecs/tas2562.c | 2 ++
> >   1 file changed, 2 insertions(+)
> > 
> > diff --git a/sound/soc/codecs/tas2562.c b/sound/soc/codecs/tas2562.c
> > index f1ff204e3ad0..19965fabe949 100644
> > --- a/sound/soc/codecs/tas2562.c
> > +++ b/sound/soc/codecs/tas2562.c
> > @@ -802,6 +802,7 @@ static const struct i2c_device_id tas2562_id[] = {
> >   };
> >   MODULE_DEVICE_TABLE(i2c, tas2562_id);
> > +#ifdef CONFIG_OF
> 
> Should we use #if IS_ENABLED(CONFIG_OF) ?

I think it does not matter:
1. OF is only bool,
2. This is the existing pattern in many driver (for OF and ACPI),
   see also: Documentation/firmware-guide/acpi/enumeration.rst
3. ifdef should be faster for preprocessor (less macros to unwind),

It would matter if OF became a module option. In such case anyway a lot
of existing ifdef CONFIG_OF would have to be corrected.

Best regards,
Krzysztof
