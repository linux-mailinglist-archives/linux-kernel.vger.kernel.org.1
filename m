Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2F11AAFA4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 19:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411040AbgDOR15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 13:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411015AbgDOR1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 13:27:43 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC722C061A10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 10:27:42 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id j20so6024760edj.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 10:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PQn/ANk0pwHlFuEamxgp0PrtqC/xvAZ3EDlh2VOe0m0=;
        b=yd+J2FgA/lmkvwZA0iSAyzd7KBbCuB/XPFMuZjRayE9JGURa/42PqYHqh7VHqG6yED
         /nIczfFJbvdoQAofGTftRvfbs5J6uDzfmUI7zWxFs+8D4fq0K2r/F4vzakBSi+Gwk7Bx
         X0xvX3stfs4GjV5EQpXvDPsua3QTuXUI9TSVNKzn1db2Q+eV16gw9MpJQd57dpb6Sr/D
         1E623YfOYHf9Av67Mp04BaCkBoZRhDoZNiVRCSubUb/X8dM1J+YRK975cPajYodiP5EX
         jhAtPq7673DF9HC3HsRN0ErLQCEH1HelkhzITVfbeLqLsX5cmWmt1bDXCJmLiAloPWcj
         YC5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PQn/ANk0pwHlFuEamxgp0PrtqC/xvAZ3EDlh2VOe0m0=;
        b=JzEaA/c96EznGrQoUsUS2UEknMJNXAvhPHl4sMT1GvOJyQlQoKYoHcZG45GLAsC94P
         +ykPqSTnEZbuugU4LQKxtBUP3jnRyA0aiWS/2lvhcYfOFevc3yHbV5MHhHpWPpXSfwDh
         ZZNr6fBlX/16vDDE4xVF5CqdtsPlIx6fdG84zEdJL/9XBEMtCDqzEEjDgAUImGPnoYw9
         EG57CoqDj8e3k97QWoeucjshf4YX4IactMpNg2ObGgHAC6GOdRuAXYV2bhKkobP3Qfyv
         kr2+ILbvhSxq2zlTsNaonIYRmsQMF98OE7ecvlo58zaReSP0HvdC4/QRjb7UO4e7BX7h
         /aLw==
X-Gm-Message-State: AGi0PubWhKFU2QkMsNEh7jFZaa4dPmByVBgcWVZwKt4SZV5L64tuZna2
        y5XL+N3AZ34ipbn7/mKhJETjL6FkoROzM/+cfr/G/w==
X-Google-Smtp-Source: APiQypJQto6RgiMwvrOJoJJZzQ2YMTpz2NolWBUDftzJdaKnsDAKa/cP6mTGhuplHbMRPC1NtLSayFuBX50THyRB8Ng=
X-Received: by 2002:a17:906:1e42:: with SMTP id i2mr5854049ejj.317.1586971661463;
 Wed, 15 Apr 2020 10:27:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200414040030.1802884-1-ira.weiny@intel.com> <20200414040030.1802884-4-ira.weiny@intel.com>
 <20200415160307.GJ90651@mit.edu>
In-Reply-To: <20200415160307.GJ90651@mit.edu>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 15 Apr 2020 10:27:30 -0700
Message-ID: <CAPcyv4jmBRsexpW2=SxqatbMK_u2aZcGnjeF+76=XwrCHfPoXA@mail.gmail.com>
Subject: Re: [PATCH RFC 3/8] fs/ext4: Disallow encryption if inode is DAX
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     "Weiny, Ira" <ira.weiny@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 9:03 AM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> On Mon, Apr 13, 2020 at 09:00:25PM -0700, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> >
> > Encryption and DAX are incompatible.  Changing the DAX mode due to a
> > change in Encryption mode is wrong without a corresponding
> > address_space_operations update.
> >
> > Make the 2 options mutually exclusive by returning an error if DAX was
> > set first.
> >
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
>
> The encryption flag is inherited from the containing directory, and
> directories can't have the DAX flag set, so anything we do in
> ext4_set_context() will be safety belt / sanity checking in nature.
>
> But we *do* need to figure out what we do with mount -o dax=always
> when the file system might have encrypted files.  My previous comments
> about the verity flag and dax flag applies here.
>
> Also note that encrypted files are read/write so we must never allow
> the combination of ENCRPYT_FL and DAX_FL.  So that may be something
> where we should teach __ext4_iget() to check for this, and declare the
> file system as corrupted if it sees this combination.  (For VERITY_FL
> && DAX_FL that is a combo that we might want to support in the future,
> so that's probably a case where arguably, we should just ignore the
> DAX_FL for now.)

We also have a pending consideration for what MKTME (inline memory
encryption with programmable hardware keys) means for file-encryption
+ dax. Certainly kernel based software encryption is incompatible with
dax, but one of the hallway track discussions I wanted to have at LSF
is whether fscrypt is the right interface for managing inline memory
encryption. For now, disallowing ENCRPYT_FL + DAX_FL seems ok if
ENCRPYT_FL always means software encryption, but this is something to
circle back to once we get MKTME implemented for volume encryption and
start to look at finer grained (per-directory key) encryption.
