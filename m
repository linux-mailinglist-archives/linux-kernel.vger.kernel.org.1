Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB2E1B1072
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Apr 2020 17:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbgDTPoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 11:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbgDTPoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 11:44:08 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2081C061A0C;
        Mon, 20 Apr 2020 08:44:06 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id x26so5229322pgc.10;
        Mon, 20 Apr 2020 08:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pE0gPfU6pLsV1RHzpYw+XY139s/iVNRLmzt4biw2kHk=;
        b=oUBHD60rSbvX1W2y33iMA1EfMWDCA/NUaExxZIa13J7cPv7ZR1GnvLG7hqvjmoTuBu
         ssZRM+/zn94KsVaSHTUbGoSpO1im9mjnEkQ1UTuOkzBfTmDyRW43F99r+HmAKNBHSJ6s
         3A+qVBzfQJXhUZLhLIdtoMsotkDrJJxklC/ROiRJo101KZBH0z12ZeZBOOFEOsBXZKTI
         Yp/ospB9LHljz+Huk5jtGYrSNm07ywyG3Wi2Lz8JJwlJLD9Q8uak9EBMGAv+R5V020rg
         khYwgGxsqwGtZ3h9CIyhschLp01oLHsqCUu+l0f4e126YOP+mtXzBIrMM69Q8Mg43XNV
         wWqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pE0gPfU6pLsV1RHzpYw+XY139s/iVNRLmzt4biw2kHk=;
        b=d5E5iV/oZ3hOwHy5rfaL2v8BwZQh4Cf0WI+WQV+FVee86G0g7S1KV1ExYp0kfAIorM
         FgbSIA6PPp5fGS8yBZIFDky4/DUtEZ0t0si5zXTySBBHC+AoU63WmINsuoMGNnn1aG+z
         Zyte/GAVj8Eg0C+HGRKb9pTkoomVZO2TwbVheuY833kShyp45r6QorU1fV2r85s3s6+u
         c4c9x31AuSKPwB25WZDg+qFXvCrbdwHhpkmiRXWampmtYNOVP7+cBcfGDJaKHBJXizWI
         KyB2J5t9WqfGc0ZWTeisQPZovXJJAUQIBSGRHb2e5K8gyDHTGzt0BoJkCtWue5Qd8mav
         n+FQ==
X-Gm-Message-State: AGi0Pub7hxYAhkNjWv/kcOsBTvrMC9T0s9MWfqOLusdQCFU7/DN4d7TT
        cH3+0SB5hLsWc0lufJtJrenJk2YfAlAJ8Epo0mWsujcQCUg=
X-Google-Smtp-Source: APiQypK9I1MdWgZGoSf+C1iy/SkiNzjbyX9tygDD3MaJXJnonU1x2uCGM3GNmSS2WB2DbiLfrbkwRvKc3zFEBwhQwAo=
X-Received: by 2002:a63:1d4:: with SMTP id 203mr16431725pgb.74.1587397446495;
 Mon, 20 Apr 2020 08:44:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200420141054.26173-1-prarit@redhat.com>
In-Reply-To: <20200420141054.26173-1-prarit@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 20 Apr 2020 18:43:59 +0300
Message-ID: <CAHp75VfKCuX1CNMaVLeghdoP9-KHh3+1yuFVgU8qhRbKi69JNQ@mail.gmail.com>
Subject: Re: [PATCH] intel-speed-select: Fix speed-select-base-freq-properties
 output on CLX-N
To:     Prarit Bhargava <prarit@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 6:11 PM Prarit Bhargava <prarit@redhat.com> wrote:
>
> On CLX-N, the perf-profile-level's output is terminated before the
> speed-select-base-freq-properties are output which results in a corrupt
> json file.
>
> Adjust the output of speed-select-base-freq-properties by one on CLX-N.
>

Thanks for the patch, it will be pulled from Srinivas' tree whenever
he sends a PR to PDx86 mailing list.


> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: platform-driver-x86@vger.kernel.org
> ---
>  tools/power/x86/intel-speed-select/isst-display.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/power/x86/intel-speed-select/isst-display.c b/tools/power/x86/intel-speed-select/isst-display.c
> index 51dbaa5f02ec..f6e2ce181123 100644
> --- a/tools/power/x86/intel-speed-select/isst-display.c
> +++ b/tools/power/x86/intel-speed-select/isst-display.c
> @@ -470,7 +470,7 @@ void isst_ctdp_display_information(int cpu, FILE *outf, int tdp_level,
>                                 _isst_pbf_display_information(cpu, outf,
>                                                               tdp_level,
>                                                           &ctdp_level->pbf_info,
> -                                                             level + 1);
> +                                                             level + 2);
>                         continue;
>                 }
>
> --
> 2.18.2
>


-- 
With Best Regards,
Andy Shevchenko
