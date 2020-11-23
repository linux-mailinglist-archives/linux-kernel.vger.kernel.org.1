Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 833CF2C1102
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 17:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388285AbgKWQpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 11:45:54 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45017 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732365AbgKWQpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 11:45:54 -0500
Received: by mail-wr1-f65.google.com with SMTP id 64so5846669wra.11
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 08:45:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tTIXw5rLyAv33bToM20XD0dcKwsOzV94mj/iEGVXRWs=;
        b=oy9bV82qhmGP0lU1dJ9z8CrDxCaO0R2bYAH/YpanNuqr0reZIvllu7qPBYwMPNBdtU
         vNDc8M8HjUbst3xWXAzOOAMUVooJ90T1UTcGULN3HEG/9qDlAAAmpwWpDUvqKJhCGHnG
         BI+MYvJi+lxOyHv6RNmzlA8zA9suF9cLkO7hOav0e51YAkiwqtlIrzyqXT+8aQ4Tmad9
         rzjM6PmWg71njkFkE/Gm/DFeLO2fV876SYNjJqcd+wcq+dPRIgr9WubnlEgEuIR8HpO4
         xcfWrsqBSyiTgey+C8YHoSRNvQK3IIHvGD/dDxdD74BoxB358oxaashrbCcfG8ia2xZO
         FMKQ==
X-Gm-Message-State: AOAM531lkSLM1bMyPg9EsXrpOacyha0BFu6i7bcb2xBoUCZ35f4LfEVv
        Bo26jJb+V/Hvg6fRVCMr2yE=
X-Google-Smtp-Source: ABdhPJwjyRPsg/ZgyyqA5febFYxtxg+7Hu3QymLN9YFEKOn7qG9Jk/Avn4KesTL8D6o4vJvRQHgSRg==
X-Received: by 2002:adf:fd0d:: with SMTP id e13mr538070wrr.85.1606149951691;
        Mon, 23 Nov 2020 08:45:51 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id d13sm22466554wrb.39.2020.11.23.08.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 08:45:49 -0800 (PST)
Date:   Mon, 23 Nov 2020 17:45:48 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH 01/38] ASoC: ak5558: drop of_match_ptr from of_device_id
 table
Message-ID: <20201123164548.GA211086@kozik-lap>
References: <20201120165202.GG6751@sirena.org.uk>
 <20201120194245.GA2925@kozik-lap>
 <20201120200429.GJ6751@sirena.org.uk>
 <20201122105813.GA3780@kozik-lap>
 <20201123104832.GY4077@smile.fi.intel.com>
 <20201123123731.GA6322@sirena.org.uk>
 <20201123124129.GA170000@kozik-lap>
 <20201123135006.GE6322@sirena.org.uk>
 <20201123145831.GA202597@kozik-lap>
 <20201123164330.GG6322@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201123164330.GG6322@sirena.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 04:43:30PM +0000, Mark Brown wrote:
> On Mon, Nov 23, 2020 at 03:58:31PM +0100, Krzysztof Kozlowski wrote:
> 
> > Having these of_match_ptr() for OF-only drivers is not the correct way
> > but rather something which is copied from existing drivers into new
> > ones. This is another reason for removing them - people will stop
> > copying this code all over again.
> 
> Well, it seems that the issue the PRP0001 people are having is that
> they'd rather that there were fewer OF only drivers!  More generally
> it is good practice to write things as though there might be non-DT
> support even if it's not there at the present time, it's easier to not
> have to think if it's strictly needed and it helps anyone coming along
> later who does want to use things elsewhere.

I understand. I will send therefore a v2 adding __maybe_unused to the OF
table.

Best regards,
Krzysztof

