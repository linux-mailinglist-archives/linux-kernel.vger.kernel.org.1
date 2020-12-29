Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB4BE2E6D7E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 04:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbgL2DK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 22:10:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbgL2DK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 22:10:26 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEAD3C061793
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 19:09:46 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id f9so7285139pfc.11
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 19:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=u5LSYcSeqxqNUQS5mYz7r4hErViy27m/hLCw3WqWA10=;
        b=b9rsft8eDiJyM+hftTFj4BiAS4UlgMzzruzWlmQbka8zVWWCN8nS1YhqcqSMEIzz/A
         BSftbF18ja4pagnGWj+iy1hLE4G82cbi+bggYmRc5goKjGMGqenp7QiwX7j/7tgS8FAA
         peCS3Ev8lKXNBlJvAgI2TKBQysIxDlwl6TRNkoUzNuml1kFdHqX25+WZgKiULY3sRRv7
         /dUalDiaS+A8IfBFYArTnr7cPJtkxyHkRPUX6rbUkKbBfCTFqhPvsAk8HZijMKWiTcey
         HaFz6H/55dWjDD8I1NK3IhPTkJF1URKZ757TxMwAPhqOBHqtiebsILHz7FXhMcJHALUQ
         p7Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=u5LSYcSeqxqNUQS5mYz7r4hErViy27m/hLCw3WqWA10=;
        b=Y3yNzN1NbBKeuNvfJ+WgEhZqEIpGaUn/u7W76eyh94qLxuNm8owHTFemxAnsYEitj+
         N7hogze3tG7Pxzx0sFmUVh5FX5+KtjxbVMmhCfCulBgQQjCLDounNeWhNj+ugN4ojA3J
         aYaEvTo9KTtCzArB0ue7XJzqQh/apdwuJf3a4A0fvzz1m6B7D6ou4MWpWdjZUdjZe7h3
         Uh1GvfTGFAGN8dg6jWeAqE/1XtmVdLkickW8ZrhWSK33cHiD6td4ZwDwk4Tat1dIYQUD
         MfgmV3ROvm5X3FmNjOj9zfChrV1yJ2JnlP9NuAJ2g2vHgXU7s3ArGQY6iGgAUPYJ3+2D
         X6DQ==
X-Gm-Message-State: AOAM531Silb61LnqTGeqaOlZ7Vl5wpPFbAHXZvo1Kldv5QZKiXBby8rV
        xnhzZSTke9mG99SIpGhPke3YaQ==
X-Google-Smtp-Source: ABdhPJxulQui9Xpbf2MYQdWGnZHZ5k/XT9rKo0slndRUUNwj1ZMb1maBNvEYECiAKrACDz5b3UJ0lA==
X-Received: by 2002:a05:6a00:230d:b029:18b:9cb:dead with SMTP id h13-20020a056a00230db029018b09cbdeadmr42775379pfh.24.1609211385223;
        Mon, 28 Dec 2020 19:09:45 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([45.137.216.7])
        by smtp.gmail.com with ESMTPSA id v9sm36673616pff.102.2020.12.28.19.09.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Dec 2020 19:09:44 -0800 (PST)
Date:   Tue, 29 Dec 2020 11:09:33 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Hans-Peter Nilsson <hp@axis.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kim Phillips <kim.phillips@arm.com>
Subject: Re: [PATCH] perf arm64: Fix mksyscalltbl, don't lose syscalls due to
 sort -nu
Message-ID: <20201229030933.GC28115@leoy-ThinkPad-X240s>
References: <20201228023941.E0DE2203B5@pchp3.se.axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201228023941.E0DE2203B5@pchp3.se.axis.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans-Peter,

On Mon, Dec 28, 2020 at 03:39:41AM +0100, Hans-Peter Nilsson wrote:
> When using "sort -nu", arm64 syscalls were lost.  That is, the
> io_setup syscall (number 0) and all but one (typically
> ftruncate; 64) of the syscalls that are defined symbolically
> (like "#define __NR_ftruncate __NR3264_ftruncate") at the point
> where "sort" is applied.
> 
> This creation-of-syscalls.c-scheme is, judging from comments,
> copy-pasted from powerpc, and worked there because at the time,
> its tools/arch/powerpc/include/uapi/asm/unistd.h had *literals*,
> like "#define __NR_ftruncate 93".
> 
> With sort being numeric and the non-numeric key effectively
> evaluating to 0, the sort option "-u" means these "duplicates"
> are removed.  There's no need to remove syscall lines with
> duplicate numbers for arm64 because there are none, so let's fix
> that by just losing the "-u".  Having the table numerically
> sorted on syscall-number for the rest of the syscalls looks
> nice, so keep the "-n".
> 
> Signed-off-by: Hans-Peter Nilsson <hp@axis.com>

Very good catching!  I tested this patch with the commands:

$ cd $LINUX_KERN
$ tools/perf/arch/arm64/entry/syscalls/mksyscalltbl \
        $ARM64_TOOLCHAIN_PATH/aarch64-linux-gnu-gcc \
        gcc tools tools/include/uapi/asm-generic/unistd.h

It gives out complete syscall tables:

$ diff /tmp/mksyscall_before.txt /tmp/mksyscall_after.txt
1a2,4
> 	[223] = "fadvise64",
> 	[25] = "fcntl",
> 	[44] = "fstatfs",
2a6,11
> 	[0] = "io_setup",
> 	[62] = "lseek",
> 	[222] = "mmap",
> 	[71] = "sendfile",
> 	[43] = "statfs",
> 	[45] = "truncate",

Rather than dropping option "-u" for sort command, I googled and read
the manual of "sort", but cannot find other better method.  So this
patch looks good for me:

Reviewed-by: Leo Yan <leo.yan@linaro.org>
Tested-by: Leo Yan <leo.yan@linaro.org>


> Cc: John Garry <john.garry@huawei.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Leo Yan <leo.yan@linaro.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Kim Phillips <kim.phillips@arm.com>
> ---
>  tools/perf/arch/arm64/entry/syscalls/mksyscalltbl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl b/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl
> index 459469b7222c..a7ca48d1e37b 100755
> --- a/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl
> +++ b/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl
> @@ -58,5 +58,5 @@ create_table()
>  
>  $gcc -E -dM -x c -I $incpath/include/uapi $input \
>  	|sed -ne 's/^#define __NR_//p' \
> -	|sort -t' ' -k2 -nu	       \
> +	|sort -t' ' -k2 -n	       \
>  	|create_table
> -- 
> 2.11.0
> 
> brgds, H-P
