Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08F402BB5AF
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 20:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728960AbgKTTmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 14:42:51 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42895 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728761AbgKTTmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 14:42:51 -0500
Received: by mail-ed1-f68.google.com with SMTP id v22so10706259edt.9
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 11:42:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jOXZ/NCVCIvYKIWpmcFp+SbynGH7tAa1IfD+gFImPbE=;
        b=aIQluDI1xzhVM7lg3XleI5zNTtwJ0gS3WLwfgOAK57BrrmXAldqm8ZS5Y9HCOgcOLB
         geAdcgx2pkXl1jJc6grUImMV4HXva7sF4JC3X+n7r5WYEqVCgAnUCpPh/YiuDpGB1Ll+
         v/OYgqQkCSkfrn/aFMz21aO52VqjRQ4M/do02M2C9KVbPempU9w7l3w1AGRybHeC8Vfl
         JB6d1U1RqKumiyNqkpGMzKs9rM/mxAGwxkbsAyFeWEH7QcqvN8Cd32/Oxs6Uhwo/GuAO
         Ywvl5iBQcX/Q8UWAQmKNaUdo6dAFAl9HQBcC63j9FMxz+QIULv1ZzFZyyFb0SsY4cwf0
         fhWQ==
X-Gm-Message-State: AOAM531bkT0W8dANFMuowAvaqrIPd6i0rF8BLpbLun7P4b2l1tLgOHgj
        oIDRMzTy7cqSENf0K6nKuY0=
X-Google-Smtp-Source: ABdhPJz8vRJ4tmub7T+MlTQoYvIJ7sDYDo7OFVZA0mTWzf4Z26ouD98jDYhqeqIh8GIHyhvgky2LXg==
X-Received: by 2002:a50:ab06:: with SMTP id s6mr29303017edc.288.1605901368051;
        Fri, 20 Nov 2020 11:42:48 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id u8sm1514624edr.2.2020.11.20.11.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 11:42:46 -0800 (PST)
Date:   Fri, 20 Nov 2020 20:42:45 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH 01/38] ASoC: ak5558: drop of_match_ptr from of_device_id
 table
Message-ID: <20201120194245.GA2925@kozik-lap>
References: <20201120161653.445521-1-krzk@kernel.org>
 <20201120165202.GG6751@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201120165202.GG6751@sirena.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 04:56:34PM +0000, Mark Brown wrote:
> On Fri, Nov 20, 2020 at 05:16:15PM +0100, Krzysztof Kozlowski wrote:
> > The driver can match only via the DT table so the table should be always
> > used and the of_match_ptr does not have any sense (this also allows ACPI
> > matching via PRP0001, even though it is not relevant here).  This fixes
> > compile warning (!CONFIG_OF on x86_64):
> 
> It would be better to fix these by annotating the table as potentially
> unused, if nothing else it means if someone wants to add ACPI support
> (or it just works on their ACPI system with the plain old I2C ID) then
> they don't need to revert this change.

The point is after this patch - removal of of_match_ptr() - they will
already support the ACPI matching through the PRP0001.

Keeping of_match_ptr() and maybe_unused will prevent any ACPI re-usage
unless explicit ACPI table is added

Best regards,
Krzysztof
