Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3967B28BA8F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 16:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731108AbgJLOQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 10:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726724AbgJLOQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 10:16:33 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55768C0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 07:16:33 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id b8so6168852wrn.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 07:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=OInMApTrSajaQRQFRFaHHuUcxdngdHyWKzS2Of4y26w=;
        b=OqdWaDHeGGLCqgMU0s1QUAhJwCoXWR7goUecYYUV1R7UAPOuMnJE2EDBnFG1AouVA5
         bTv/BN99pSSGacxBMVMCFfXT2Vscv30QTyryoJv9h+nTwnpXM+sFqu1Qr2/HHw6pro2m
         u9/tkVZ1QiKX7qSSxWDdpgb0EmfuEPUOz9TJ8BoQEkx7/2M3oPrknWW70QgYxbEhIWub
         Fy8U3q3DPY97RXjOu8lBOHZ8aihGiQmFyqVj0jViPb7zS/nSvTqwBCzpi1sCc2Zxbg6N
         HXb9XfSK7akQZHeLfRethvLZG8dg1rUzjyK3DvNGNqy3jEZgA7anSLbKITW76D3Gxh5J
         4eAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=OInMApTrSajaQRQFRFaHHuUcxdngdHyWKzS2Of4y26w=;
        b=NYr98KaNEtLIQYTpEHxIeS4+oSzLB+OiGeu/mVPCxFSyzKpEoiGc0KACq1+JXiOmVI
         9ZhxJA3Hg5FwkD30X6/ncdnbFwPPope7WMu9wpzNAle1BdEMegwmm8jkmJcj56XfUrfd
         l3M+LfwRtNR3CONKQqc6m0XNhyuxahgusvwKFOACK/1+D5Zl3NYktnTOO6Z9EkERwPVl
         ap5r3X+2//tiLxElx7D0uZzPbyb4tanioX5SCSiOGrjReBlR8KA3CGMBmBkWiTt7luL2
         a+c34N7sLcICJVsTqjAbQJK40n9kmHzVctfEdS+sMdk0aJK5elsW/15RBfE1UIkHpq0P
         cZ+g==
X-Gm-Message-State: AOAM532JIh3F4KvCwdo0qwZrWZD2z9wN4AaybjIJIN8ZWys0kHW3vwwh
        XMEC8IMLuTsjB2RmKcjaFanDPW1WLfdPNZ9K
X-Google-Smtp-Source: ABdhPJzP9goTvjOWkThIqN0Zn1EcOGTBEGSneY+CxFIYRR6GHAGz10uK1MjsZwRSEBuQHkI94sYEpg==
X-Received: by 2002:a5d:498a:: with SMTP id r10mr30745031wrq.106.1602512191918;
        Mon, 12 Oct 2020 07:16:31 -0700 (PDT)
Received: from felia ([2001:16b8:2d57:fc00:8472:203c:3ecb:c442])
        by smtp.gmail.com with ESMTPSA id d23sm23268371wmb.6.2020.10.12.07.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 07:16:31 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Mon, 12 Oct 2020 16:16:30 +0200 (CEST)
X-X-Sender: lukas@felia
To:     Ujjwal Kumar <ujjwalkumar0501@gmail.com>
cc:     Joe Perches <joe@perches.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] checkpatch: add shebang check to
 EXECUTE_PERMISSIONS
In-Reply-To: <5a3fc45f-e5d7-da3d-4b4b-2a23512ff8de@gmail.com>
Message-ID: <alpine.DEB.2.21.2010121612150.6487@felia>
References: <20201012054943.1196031-1-ujjwalkumar0501@gmail.com> <63053585d41ff81cdaad6cb727eb83d81207041a.camel@perches.com> <5a3fc45f-e5d7-da3d-4b4b-2a23512ff8de@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 12 Oct 2020, Ujjwal Kumar wrote:

> On 12/10/20 11:47 am, Joe Perches wrote:
> > On Mon, 2020-10-12 at 11:19 +0530, Ujjwal Kumar wrote:
> >> checkpatch.pl checks for invalid EXECUTE_PERMISSIONS on source
> >> files. The script leverages filename extensions and its path in
> >> the repository to decide whether to allow execute permissions on
> >> the file or not.
> >>
> >> Based on current check conditions, a perl script file having
> >> execute permissions, without '.pl' extension in its filename
> >> and not belonging to 'scripts/' directory is reported as ERROR
> >> which is a false-positive.
> >>
> >> Adding a shebang check along with current conditions will make
> >> the check more generalised and improve checkpatch reports.
> >> To do so, without breaking the core design decision of checkpatch,
> >> we can fetch the first line from the patch itself and match it for
> >> a shebang pattern.
> >>
> >> There can be cases where the first line is not part of the patch.
> > 
> > For instance: a patch that only changes permissions
> > without changing any of the file content.
> > 
> >>
> >> In that case there may be a false-positive report but in the end we
> >> will have less false-positives as we will be handling some of the
> >> unhandled cases.
> > 
> >> Signed-off-by: Ujjwal Kumar <ujjwalkumar0501@gmail.com>
> >> ---
> >> Apologies, I forgot to include linux-kernel@vger.kernel.org so I'm
> >> now resending.
> >>
> >>  scripts/checkpatch.pl | 19 +++++++++++++++++++
> >>  1 file changed, 19 insertions(+)
> >>
> >> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > []
> >> @@ -1795,6 +1795,23 @@ sub get_stat_here {
> >>  	return $herectx;
> >>  }
> > 
> > First some style trivia:
> > 
> >> +sub get_shebang {
> >> +	my ($linenr, $realfile) = @_;
> >> +	my $rawline = "";
> >> +	my $shebang = "";
> >> +
> >> +	$rawline = raw_line($linenr, 3);
> >> +	if (defined $rawline &&
> >> +		$rawline =~ /^\@\@ -\d+(?:,\d+)? \+(\d+)(,(\d+))? \@\@/) {
> > 
> > alignment to open parenthesis please
> > 
> >> +		if (defined $1 && $1 == 1) {
> >> +			$shebang = raw_line($linenr, 4);
> >> +			$shebang = substr $shebang, 1;
> > 
> > parentheses around substr please.
> > 
> >> +		}
> >> +	}
> >> +
> >> +	return $shebang;
> >> +}
> > 
> > And some real notes:
> > 
> > $realfile isn't used in this function so there doesn't
> > seem to be a reason to have it as an function argument.
> > 
> >> +
> >>  sub cat_vet {
> >>  	my ($vet) = @_;
> >>  	my ($res, $coded);
> >> @@ -2680,7 +2697,9 @@ sub process {
> >>  # Check for incorrect file permissions
> >>  		if ($line =~ /^new (file )?mode.*[7531]\d{0,2}$/) {
> > 
> > probably better here to use a capture group for the permissions
> > 
> > 		if ($line =~ /^new (?:file )?mode (\d+)$/) {
> > 			my $mode = substr($1, -3);
> 
> This
> 
> > 
> >>  			my $permhere = $here . "FILE: $realfile\n";
> >> +			my $shebang = get_shebang($linenr, $realfile);
> >>  			if ($realfile !~ m@scripts/@ &&
> > 
> > Maybe remove the $realfile directory test as
> > there are many source files that are not scripts
> > in this directory and its subdirectories.
> 
> this
> 
> > 
> >> +			    $shebang !~ /^#!\s*(\/\w)+.*/ &&
> > 
> > unnecessary capture group
> > 
> > and add
> > 
> > 			   $mode =~ /[1357]/ &&
> 
> this
> 
> > 
> >>  			    $realfile !~ /\.(py|pl|awk|sh)$/) {
> > 
> > No need for a a capture group here either. (existing defect)
> 
> and this.
> 
> > 
> >>  				ERROR("EXECUTE_PERMISSIONS",
> >>  				      "do not set execute permissions for source files\n" . $permhere);
> > 
> > 
> > 
> 
> Should these new changes go as a separate patch or can they be
> included in the next iteration of this patch?
> 
>

Ujjwal, please consider the following 'strategy':

- Send one patch to clean up the existing implementation as Joe requested.

With those 'credit points' for cleaning up the implementation, you then:

- Send another clean patch for the additional functionality you propose

We can probably easily accept the first cleanup, and then dig into the 
review of the additional functionality.

Lukas
