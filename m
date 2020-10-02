Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 832AD2815B7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 16:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388203AbgJBOtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 10:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387990AbgJBOtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 10:49:52 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2E7C0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 07:49:50 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id u3so916944pjr.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 07:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=Khn8CfhobmHbzhXXTDMSt4Dh601ttzUMdRYWXwdYRPo=;
        b=DJVCRzdqpxICqnwpdEMu4UOgh8muUdxeYvAVfpAOME/Py3vcwz4BdGQvhysx3sFU5K
         ClVes1oURmnz88HUcBumi4d8BRhUwlKGdr0ysmvUMNdIkBXRUBCevHT/W9lm4z8C0nCm
         yCEK+RCjzMOER5R6r8qy+1lMKE1wJYRQ41NqFMAnmwooDIdDyjlbV+N/ydWo3M9lElcq
         ihBGTM3yXXWNktTz1UL/6HIFHunHziDgityBGyiEiydATqvfVA0zW9/IIiDalAy8XqPu
         yOX8otRKWm0NkJj24ogiGE3CtQ9DS56Jeatu9vlLDoKhJe+2ohnw+B0u9rw0HosMpVDp
         C6gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=Khn8CfhobmHbzhXXTDMSt4Dh601ttzUMdRYWXwdYRPo=;
        b=k4FblZ6E3EIP2gAji3/rnUEnOUxDveZsdgqGHLZ0RqwctJBYO5RemohR1OQ/MeA08Q
         7hreeVMXfoMRzcps4CMUPE8cXyXU3syzGmAYKQCBry9chlx5vmdKSXdyxVDpQ41623xU
         Zdvfm5tAlAVQ6vxXcRv5QFrGeHnPEsbe5AD7NFw4FygEepuODlCAjK+PWm1+XClZJ3LK
         pLZlIBeyxCGMAecFZId0+7DnAhtvHg5QrteUJP7Iqe7+eWqO2q01l3UbbCc+Z47FqV8G
         TpE7HhqDXzVfYin45mzHbxQF/NbLfb4hfVA7vG8xN0psBkERqjv/+EP74ZWvjn1kKJG6
         f2Hw==
X-Gm-Message-State: AOAM5324JB6Jq+yZYUG8Ts6pZK+BkmL/xRx+4Dv/0Mq9J55/7XPg1mQr
        rQC6UAdv8YDTiKTD1xYXDgc+1J4gSUs2Vw==
X-Google-Smtp-Source: ABdhPJxwW3dtMkRmIG5bjtfHXLP/iJtqLM2Vvz1Qub+OGsJcG5JmRFgbh6HpS0hiEJPKxStWbCVnOg==
X-Received: by 2002:a17:90b:241:: with SMTP id fz1mr1137101pjb.17.1601650190202;
        Fri, 02 Oct 2020 07:49:50 -0700 (PDT)
Received: from Gentoo (sau-465d4-or.servercontrol.com.au. [43.250.207.1])
        by smtp.gmail.com with ESMTPSA id h9sm1720278pfh.213.2020.10.02.07.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 07:49:49 -0700 (PDT)
Date:   Fri, 2 Oct 2020 20:19:36 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "kernel-mentors@selenic.com" <kernel-mentors@selenic.com>,
        kernelnewbies <kernelnewbies@kernelnewbies.org>
Subject: Re: external tool to remove embedded filenames
Message-ID: <20201002144936.GA17987@Gentoo>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "kernel-mentors@selenic.com" <kernel-mentors@selenic.com>,
        kernelnewbies <kernelnewbies@kernelnewbies.org>
References: <1fd5f9188a14acdca703ca00301ee323de672a8d.camel@perches.com>
 <bab3ecae932cb41106834156abbd27159d937e67.camel@perches.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline
In-Reply-To: <bab3ecae932cb41106834156abbd27159d937e67.camel@perches.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 11:47 Thu 01 Oct 2020, Joe Perches wrote:
>It's rather unnecessary for files to contain their
>path/filename in source code comments.
>
>Here's a trivial little script that can remove
>embedded filenames in c90 style comments from files.
>
>This requires git.
>
>It does the following types of removals:
>
>remove individual lines like /* filename */ completely
>remove filename from /* filename -- comment */, leave /* comment */
>remove filename and any trailing ' *\n' from /* filename, leave /*
>remove filename from /* filename, leave /*
>remove filename from continuation ' * filename -- comment' leave ' * comment'
>remove filename and any trailing ' *\n' from continuation ' * filename\n *\n'
>
>It seems to work well enough.
>
>It does not handle c99 comments.
>No // filename variants are removed.
>
>Running it on today's -next gives:
>
>$ perl remove_embedded_filenames.pl
>$ git diff --shortstat
> 2310 files changed, 354 insertions(+), 4239 deletions(-)
>
>It's also possible to give any filename or path
>as an argument to the script
>
>For instance:
>
>$ perl remove_embedded_filenames.pl drivers/net
>

>#!/usr/bin/perl -w
>
># script to remove * <filename> comments;
># use: perl remove_embedded_filenames.pl <paths|files>
># e.g.: perl remove_embedded_filenames.pl drivers/net/ethernet/intel
>
>use strict;
>
>my $P = $0;
>my $modified = 0;
>my $quiet = 0;
>
>sub expand_tabs {
>    my ($str) = @_;
>
>    my $res = '';
>    my $n = 0;
>    for my $c (split(//, $str)) {
>	if ($c eq "\t") {
>	    $res .= ' ';
>	    $n++;
>	    for (; ($n % 8) != 0; $n++) {
>		$res .= ' ';
>	    }
>	    next;
>	}
>	$res .= $c;
>	$n++;
>    }
>
>    return $res;
>}
>
>my $args = join(" ", @ARGV);
>my $output = `git ls-files -- $args`;
>my @files = split("\n", $output);
>
>foreach my $file (@files) {
>    my $f;
>    my $cvt = 0;
>    my $text;
>
># read the file
>
>    next if ((-d $file));
>
>    open($f, '<', $file)
>	or die "$P: Can't open $file for read\n";
>    $text = do { local($/) ; <$f> };
>    close($f);
>
>    next if ($text eq "");
>
># Remove the embedded filenames
>
>    # remove individual lines like /* filename */ completely
>    $cvt += $text =~ s@/\*[ \t]+(?:linux\/)?\Q$file\E[ \t]*\*/[ \t]*\n@@g;
>    pos($text) = 0;
>    # remove filenamee from /* filename -- comment */, leave /* comment */
>    $cvt += $text =~ s@/\*([ \t]+)(?:linux\/)?\Q$file\E[ \t]*[:-]+[ \t]*@/*$1@g;
>    pos($text) = 0;
>    # remove filename and any trailing ' *\n' from /* filename, leave /*
>    $cvt += $text =~ s@/\*([ \t]+)(?:linux\/)?\Q$file\E[ \t]*\n([ \t]*\*[ \t]*\n)*(?:[ \t]*\*)?@/*@g;
>    pos($text) = 0;
>    # remove filename from /* filename, leave /*
>    $cvt += $text =~ s@/\*([ \t]+)(?:linux\/)?\Q$file\E[ \t]*\n@/*@g;
>    pos($text) = 0;
>    # remove filename from continuation ' * filename -- comment'
>    # leave ' * comment'
>    $cvt += $text =~ s/([ \t]+)\*([ \t]*)(?:linux\/)?\Q$file\E[ \t]*[:-]+[ \t]*/$1*$2/g;
>    pos($text) = 0;
>    # remove filename and any trailing ' *\n' from
>    # continuation ' * filename\n *\n'
>    $cvt += $text =~ s/([ \t]*)\*([ \t]*)(?:linux\/)?\Q$file\E[ \t]*\n([ \t]*\*[ \t]*\n)*//g;
>    pos($text) = 0;
>
># write the file if something was changed
>
>    if ($cvt > 0) {
>	$modified = 1;
>	print("$file\n");
>	open($f, '>', $file)
>	    or die "$P: Can't open $file for write\n";
>	print $f $text;
>	close($f);
>    }
>}
>
>if ($modified && !$quiet) {
>    print <<EOT;
>
>Warning: these changes may not be correct.
>
>These changes should be carefully reviewed manually and not combined with
>any functional changes.
>
>Compile, build and test your changes.
>
>You should understand and be responsible for all object changes.
>
>Make sure you read Documentation/SubmittingPatches before sending
>any changes to reviewers, maintainers or mailing lists.
>EOT
>}
  Joe,

  Suggestion.... please take those damn EOT lines out of it ..absolutely not
  required...or did you put for your own purpose?? As I believe it not the final
  product. Anyway, it would be good if those not there.

  Yup, I do like the "individual option" stuff ...so, you can only mess around
  single thing than the whole lot.

  ~Bhaskar


--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAl93PfwACgkQsjqdtxFL
KRV9CQgAhFY2kGXd+1qEwoZeNs7nVKb4v62+/RE8wWKm5Ys1RpiRjIRbRT3TJzxO
EM+KzisFPmI6hHW51UJcve4QJn06DlddjdRe/VE2ioHPjz/UEScaBQ2K3qzT+7QE
ARKMRRNCwPZIoUM/hZBXUhAmDoPzn0XPr2+/uLdA+6sqUo2BwTY/Y/AP/mEWmXyv
1MYxxsKmI+cQeRgXOde/Z17Rc7udjUbSk9jFUrtJyH6Fle1DuZAkYaEL5H9plua5
TePwFi9u+OmtptxTlTGLIi8wIBMOIDjS+xSDbodL0shR74eDYRLOUOcDd0FlmoFm
eNaL2ptBn+bFXIUsQ/mj1RGTrtjNVQ==
=D+Sc
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--
