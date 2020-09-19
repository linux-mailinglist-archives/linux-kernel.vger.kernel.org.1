Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD555270FF0
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 20:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgISSMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Sep 2020 14:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbgISSMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Sep 2020 14:12:54 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E13CC0613CE
        for <linux-kernel@vger.kernel.org>; Sat, 19 Sep 2020 11:12:54 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id w5so8729322wrp.8
        for <linux-kernel@vger.kernel.org>; Sat, 19 Sep 2020 11:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=igZ3yuYSihjkAl8l2bbx70F4SPOMsCwAFAVFNrs+xjw=;
        b=M9J2UKcqidPe+jOkl4EQ5aOT45tzxn55SdpbkqbqeMy0CNq/MPdy2AHaIN67udH1gF
         /NbLTLJs/HFhGhVpmYi6vAB1M0UdoegvCYl8qaDp4+OgbFkXAuIJG+xGvzp6Z+CPYtL3
         hbOR2B0a+EY/taGitXQNcz3VT3PM3L16Fji9w/VXwJdPKtDcP1JXJuIvhnvHGMkdMe0s
         bI84sx3EhfbJuVg2L1l/ACOpZ9U4JZxtSi5fEDldiVmolCMbam1wGHnfjXvP1fZF9tJ8
         du5aXRmtio3bbjhMcII3JrHvy+uqteC/09tGQhERC7OeJJYNCLiIzdO5vQg0tTPIFmob
         TwFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=igZ3yuYSihjkAl8l2bbx70F4SPOMsCwAFAVFNrs+xjw=;
        b=fAQ8q6gTFiyDO3Tp/laepUk1WiGyL8fGoWWNVAwS/1IspjXyatLRpngXd+coL+f+xn
         Xl6gsgHA6tz2xSYIzAB1Kmjf1u19DbUIOVZmDmSmciugO3ki8tiVfGylwA+mGyMAFKJN
         wuiDPSUaH1p/Iq+2+doRoC/dgmbHi78jNnLKxhiWZdnmSbDxCznOHtTio1lD/U/+P22w
         wUVN2Bj8n1qn/rvqDMXrfIyuzKPnwpwZGArm2t6WmtRIR/qn1NMmhoHRa2MPaF1T+9Gv
         hY5xdPXQct5GyNpmnHsiPJWFHCoi1MLTzklAdjtmqBSSVSAlYhnf/Ws1CtbRNU32uTpl
         BwiA==
X-Gm-Message-State: AOAM531YC98TePpENVNV09UZSunFyLHfMF/w4ifks7GIK5wF9DSap+f4
        92uR5AsicAoF6jZUeyUiQTI=
X-Google-Smtp-Source: ABdhPJyn10xbEE/jNHZooWdw5LV/avSOktcDWkNd9VlNb+zyIXOMSvcb9TpcLxgH419p4IBX59TwvA==
X-Received: by 2002:a5d:440d:: with SMTP id z13mr16508040wrq.352.1600539172424;
        Sat, 19 Sep 2020 11:12:52 -0700 (PDT)
Received: from felia ([2001:16b8:2dba:3d00:c552:323e:8340:ec83])
        by smtp.gmail.com with ESMTPSA id q20sm10722037wmj.5.2020.09.19.11.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2020 11:12:51 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Sat, 19 Sep 2020 20:12:50 +0200 (CEST)
X-X-Sender: lukas@felia
To:     Joe Perches <joe@perches.com>
cc:     Dwaipayan Ray <dwaipayanray1@gmail.com>, lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org, apw@canonical.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] checkpatch: extend author Signed-off-by check for split
 From: header
In-Reply-To: <ad937bba6ebd306f6e467add90cfd857bb4f2391.camel@perches.com>
Message-ID: <alpine.DEB.2.21.2009191950460.7901@felia>
References: <20200919081225.28624-1-dwaipayanray1@gmail.com> <ad937bba6ebd306f6e467add90cfd857bb4f2391.camel@perches.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 19 Sep 2020, Joe Perches wrote:

> On Sat, 2020-09-19 at 13:42 +0530, Dwaipayan Ray wrote:
> > Checkpatch did not handle cases where the author From: header
> > was split into two lines. The author string went empty and
> > checkpatch generated a false NO_AUTHOR_SIGN_OFF warning.
> 
> It's good to provide an example where the current code
> doesn't work.
>

Joe, as this is a linux-kernel-mentees patch, we discussed that before 
reaching out to you; you can find Dwaipayan's own evaluation here:

https://lore.kernel.org/linux-kernel-mentees/CABJPP5BOTG0QLFSaRJTb2vAZ_hJf229OAQihHKG4sYd35i_WMw@mail.gmail.com/

Dwaipayan, Joe's comment is still valid; it would be good to describe
the reasons why patches might have split lines (as far as see, long 
encodings for non-ascii names).

I will run my own evaluation of checkpatch.pl before and after patch 
application on Monday and then check if I can confirm Dwaipayan's results.

> It likely would be better to do this by searching forward for
> any extension lines after a "^From:' rather than searching
> backwards as there can be any number of extension lines.
>

Just to sure what you are talking about...

You mean just to access the next line through the lines array, rather 
than using prevheader and trying to decode that one line twice.

I agree the logic is a bit redundant and complicated at the moment.

Once prevheader is non-empty, it already clear that author is '' and 
prevheader decodes with that match, because that is the only way to
make prevheader non-empty in the first place; at least as far I see it 
right now.


Lukas
 
> > Support split From: headers in AUTHOR_SIGN_OFF check by adding
> > an additional clause to resolve author identity in such cases.
> > 
> > Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
> > ---
> >  scripts/checkpatch.pl | 28 ++++++++++++++++++++++++----
> >  1 file changed, 24 insertions(+), 4 deletions(-)
> > 
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > index 504d2e431c60..86975baead22 100755
> > --- a/scripts/checkpatch.pl
> > +++ b/scripts/checkpatch.pl
> > @@ -1210,6 +1210,16 @@ sub reformat_email {
> >  	return format_email($email_name, $email_address);
> >  }
> >  
> > +sub format_author_email {
> > +	my ($email, $from) = @_;
> > +
> > +	$email = encode("utf8", $email) if ($from =~ /=\?utf-8\?/i);
> > +	$email =~ s/"//g;
> > +	$email = reformat_email($email);
> > +
> > +	return $email;
> > +}
> > +
> >  sub same_email_addresses {
> >  	my ($email1, $email2) = @_;
> >  
> > @@ -2347,6 +2357,7 @@ sub process {
> >  	my $signoff = 0;
> >  	my $author = '';
> >  	my $authorsignoff = 0;
> > +	my $prevheader = '';
> >  	my $is_patch = 0;
> >  	my $is_binding_patch = -1;
> >  	my $in_header_lines = $file ? 0 : 1;
> > @@ -2658,12 +2669,21 @@ sub process {
> >  			}
> >  		}
> >  
> > +# Check the patch for a split From:
> > +		if($prevheader ne '') {
> > +			if ($author eq '' && decode("MIME-Header", $prevheader) =~ /^From:\s*(.*)/) {
> > +				my $email = $1.$line;
> > +				$author = format_author_email($email, $prevheader);
> > +			}
> > +			$prevheader = '';
> > +		}
> > +
> >  # Check the patch for a From:
> >  		if (decode("MIME-Header", $line) =~ /^From:\s*(.*)/) {
> > -			$author = $1;
> > -			$author = encode("utf8", $author) if ($line =~ /=\?utf-8\?/i);
> > -			$author =~ s/"//g;
> > -			$author = reformat_email($author);
> > +			$author = format_author_email($1, $line);
> > +			if($author eq '') {
> > +				$prevheader = $line;
> > +			}
> >  		}
> >  
> >  # Check the patch for a signoff:
> 
> 
