Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38F63271C43
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 09:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgIUHtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 03:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbgIUHtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 03:49:04 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24EBC061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 00:49:03 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id e22so11822655edq.6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 00:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=t+tsRLPb2SEvejhn0HvmhWNe8S705Wa+z+bDjNfQmrM=;
        b=OeEpp92IIkLvk6nWBn4nKCy3wkAwAe3RiLNzfwaw3+tR7TvhLxpfXDaBQCv3E/k7op
         lhDG/XjSlgD25PPHcW/gWeV2pZ80fF4URZrdzq3eqB9STA/ZIZPROnOmbbhDMgv6N+9z
         yvKVYeuhhmugWVihyP9Z5ZsX5ce24YqaheNfW1NEwa+B9oLfrPGQwo79+fJFvZ0hRF3O
         D2nMOLEojqRUZ0HtXEI4UhPQgZIj/ZgqpWwUBqhjtlcLeEBlXl9yXXwyLd0yLzOn3Hf3
         +766wHGJa/PaNUV4DVms8Bhu/yv09wXsdYuNvcUHENDUsGKH+addJaDl1/6rkFM7hhdN
         bMDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=t+tsRLPb2SEvejhn0HvmhWNe8S705Wa+z+bDjNfQmrM=;
        b=OcyOL3S9E8JvKxNO1ZP5BfGGdMeb9RIq4tWOxQndJJbW/wZl8oO0BREBzRrj+HmzJJ
         qYWidN2llq2oGrp8Gl6EQbaJrmhtHFXhwSzCzCbqFkMSDk6SWWEK8O/nkUfn+azmBiRK
         tDDi7mm6S2NuzoI9sDI4TaVSkpn3Uwiv/yPj+kMPyHSf0D0Cd/+Lwa5Ctte/Dz3uPPAm
         RwaSMxHesV+O8o71EkQczsWeBE54d44E2+DKLd+O+l34ryXONgvclB2/N3ggUOKkW3OD
         NFjqWqqTvXR83EtnqPMd00OgyzyNSGDLtWxpbo8iDNqitWhfyfvtoB9bcRhWHT1VzSqj
         1OaQ==
X-Gm-Message-State: AOAM5319pZai/dcArjMF0RXUjYEavArfBIkC2X1o3Z8fgFmYdOxqx2vD
        3yVoidd+hmzjVIn57DroOeo4ZuVOvG+zPg==
X-Google-Smtp-Source: ABdhPJzU1Lzvq6YnN6esUo217Apk/bpjAe4IkibtSr/cryEiT8GkzkpuokezOB1Hj65twKh/bjrlOQ==
X-Received: by 2002:a05:6402:50f:: with SMTP id m15mr52912016edv.41.1600674542397;
        Mon, 21 Sep 2020 00:49:02 -0700 (PDT)
Received: from felia ([2001:16b8:2d52:a400:69ec:6d66:6c4c:48])
        by smtp.gmail.com with ESMTPSA id y9sm8077042edo.37.2020.09.21.00.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 00:49:01 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Mon, 21 Sep 2020 09:49:00 +0200 (CEST)
X-X-Sender: lukas@felia
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
cc:     joe@perches.com, lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org, apw@canonical.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] checkpatch: extend author Signed-off-by check for
 split  From: header
In-Reply-To: <20200920091706.56276-1-dwaipayanray1@gmail.com>
Message-ID: <alpine.DEB.2.21.2009210940060.7483@felia>
References: <20200920091706.56276-1-dwaipayanray1@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Dwaipayan, just a quick nitpick:

Your subject line has two spaces in front of 'From:'

On Sun, 20 Sep 2020, Dwaipayan Ray wrote:

> Checkpatch did not handle cases where the author From: header
> was split into multiple lines. The author identity could not
> be resolved and checkpatch generated a false NO_AUTHOR_SIGN_OFF
> warning.
> 
> A typical example is Commit e33bcbab16d1 ("tee: add support for

You can write 'Commit' lowercase as 'commit'.

> session's client UUID generation"). When checkpatch was run on
> this commit, it displayed:
> 
> "WARNING:NO_AUTHOR_SIGN_OFF: Missing Signed-off-by: line by nominal
> patch author ''"
> 
> This was due to split header lines not being handled properly and
> the author himself wrote in Commit cd2614967d8b ("checkpatch: warn
> if missing author Signed-off-by"):
>

Same here.
 
> "Split From: headers are not fully handled: only the first part
> is compared."
> 
> Support split From: headers by correctly parsing the header
> extension lines. RFC 2822, Section-2.2.3 stated that each extended
> line must start with a WSP character (a space or htab). The solution
> was therefore to concatenate the lines which start with a WSP to
> get the correct long header.
> 
> Suggested-by: Joe Perches <joe@perches.com>
> Link: https://lore.kernel.org/linux-kernel-mentees/f5d8124e54a50480b0a9fa638787bc29b6e09854.camel@perches.com/
> Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>



On v5.4..v5.7 using data from a previous evaluation, I found 116 commits 
with
the error message "Missing Signed-off-by: line by nominal patch author 
''",
when running ./scripts/checkpatch.pl on v5.9-rc6.


After this patch application, all 116 warnings disappeared with "Missing 
Signed-off-by: line by nominal patch author ''"
and these three new warnings appeared:

322f6a3182d42df18059a89c53b09d33919f755e:35: WARNING: Missing Signed-off-by: line by nominal patch author 'Johnson CH Chen <JohnsonCH.Chen@moxa.com>'
18977008f44c66bdd6d20bb432adf71372589303:37: WARNING: Missing Signed-off-by: line by nominal patch author '"Marek Szyprowski via Linux.Kernel.Org" <m.szyprowski=samsung.com@linux.kernel.org>'
ed3520427f57327f581de0cc28c1c30df08f0103:51: WARNING: Missing Signed-off-by: line by nominal patch author 'Chengguang Xu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>'

With that said, I think am happy to add my tags:

Reviewed-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Tested-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Dwaipayan, you can fix the minor commit message issues above, add the tags 
from Joe and me to the end of your commit message and send the patch as v3 
out to Andrew Morton with everyone sofar as CC. Andrew Morton will pick up 
the patch and make it travel to Linus Torvalds.

Good job so far!

After you did that, let us develop and discuss a plan to refine the 
'trickier' part of false AUTHOR_SIGN_OFF warnings for developer and 
maintainers with some known special author and sign-off procedures.

Lukas

> ---
>  scripts/checkpatch.pl | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 504d2e431c60..9e65d21456f1 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -2661,6 +2661,10 @@ sub process {
>  # Check the patch for a From:
>  		if (decode("MIME-Header", $line) =~ /^From:\s*(.*)/) {
>  			$author = $1;
> +			my $curline = $linenr;
> +			while(defined($rawlines[$curline]) && ($rawlines[$curline++] =~ /^[ \t]\s*(.*)/)) {
> +				$author .= $1;
> +			}
>  			$author = encode("utf8", $author) if ($line =~ /=\?utf-8\?/i);
>  			$author =~ s/"//g;
>  			$author = reformat_email($author);
> -- 
> 2.27.0
> 
> 
