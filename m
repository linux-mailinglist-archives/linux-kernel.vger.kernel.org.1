Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA3632947DB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 07:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407826AbgJUF2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 01:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407778AbgJUF2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 01:28:02 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B111C0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 22:28:01 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id o9so610951plx.10
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 22:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7GB5y84r6xMSGeFUmcejHOzMFE3WByKQWJdu7wCKtTc=;
        b=RWYA4HDjyZRR/gOIdhaMUvs6IOrXEQ7pFlvkdy5B1AY+pEfSru5e/kxQXIs2jIARnG
         fW7TnyQVYuoWoErldkcgG3slDRoi4tq7RkYTAZtJ1NQuUdnK0RflcDnO6jU1c2F8ExIJ
         CCp8bLDyIoiI1qyt3/HuIlCI0G1l6Tf2iu9aUj2jVfRCez2hf2t6aIClifyB54An/nC/
         jCAykXyhzTQDSaa87W07nHg5+d6v5TTjRSC+84Dst1jFWKubk0dXOvh54JZYzILHIK+L
         uHY6LnpAr0a9id+prj0iNIKObARtsh8b1QV+J3pK+oVMu5oprB1f0rk4AxgcxEVju2i5
         8mfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7GB5y84r6xMSGeFUmcejHOzMFE3WByKQWJdu7wCKtTc=;
        b=pxPwqrcvdxCikyy08DVHX64ayvfiBFqR5bpEFzQvep11o6hP68xTI+k4BK+V9PuSfx
         wDkgTTETLdwiljUIOCbsIMC6Vv0QBEP9lpKvEye6hscotvBE/Sq0izmCMYV8ayUYHMSA
         jpZZ3U38lMC1MSSE3Z07Uyo2g2pvU1Q82jqPEpjABxd9QUkdOl02lZI42ls/3n1eGO7J
         ZIL8Z65zaDcCg1Z4h/f+/C9hem7ewuVE0AKodtr4Saszt42p6Zk2+WXGo4O5TulMWWJ1
         5stpXSueHohsWSc/VvJQWjTMmyZts4BBrNn1NOeFQz1tNK+ljew3jBJQEd9odP1HRzBA
         8cZQ==
X-Gm-Message-State: AOAM5338bmm5LnYzyTLgO07PMqzEHrYktuNcJ9pTNFosAIfSbPAHSTbP
        2dtMwp0QNPC3pumengR4EDjp9lbmPJDsdeGH
X-Google-Smtp-Source: ABdhPJz/C1gaOL5hjy8zFTXccY3UyWJy8F9I2GVGOtdTnA9WyL1I4Sz6zoWRWPflnNBRW2alRjjx8A==
X-Received: by 2002:a17:902:c697:b029:d3:df24:163e with SMTP id r23-20020a170902c697b02900d3df24163emr1837466plx.18.1603258080533;
        Tue, 20 Oct 2020 22:28:00 -0700 (PDT)
Received: from google.com (154.137.233.35.bc.googleusercontent.com. [35.233.137.154])
        by smtp.gmail.com with ESMTPSA id 194sm713228pfz.182.2020.10.20.22.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 22:27:59 -0700 (PDT)
Date:   Wed, 21 Oct 2020 05:27:55 +0000
From:   Satya Tangirala <satyat@google.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Mike Snitzer <snitzer@redhat.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        dm-devel@redhat.com, Alasdair Kergon <agk@redhat.com>
Subject: Re: [PATCH v2 1/4] block: keyslot-manager: Introduce passthrough
 keyslot manager
Message-ID: <20201021052755.GA1165871@google.com>
References: <20201015214632.41951-1-satyat@google.com>
 <20201015214632.41951-2-satyat@google.com>
 <20201016072044.GB14885@infradead.org>
 <20201021044423.GB3939@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201021044423.GB3939@sol.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 09:44:23PM -0700, Eric Biggers wrote:
> On Fri, Oct 16, 2020 at 08:20:44AM +0100, Christoph Hellwig wrote:
> > And this just validates my argument that calling the inline crypto work
> > directly from the block layer instead of just down below in blk-mq was
> > wrong.  We should not require any support from stacking drivers at the
> > keyslot manager level.
> 
> I'm not sure what you're referring to here; could you clarify?
> 
> It's true that device-mapper devices don't need the actual keyslot management.
> But they do need the ability to expose crypto capabilities as well as a key
> eviction function.  And those are currently handled by
> "struct blk_keyslot_manager".  Hence the need for a "passthrough keyslot
> manager" that does those other things but not the actual keyslot management.
> 
> FWIW, I suggested splitting these up, but you disagreed and said you wanted the
> crypto capabilities to remain part of the blk_keyslot_manager
> (https://lkml.kernel.org/linux-block/20200327170047.GA24682@infradead.org/).
> If you've now changed your mind, please be clear about it.
> 
I thought what Christoph meant (and of course, please let us know
if I'm misunderstanding you, Christoph) was that if blk-mq
handled all the blk-crypto stuff including deciding whether to
use the blk-crypto-fallback, and blk-mq was responsible for
calling out to blk-crypto-fallback if required, then the device
mapper wouldn't need to expose any capabilities at all... or at
least not for bio-based device mapper devices, since bios would
go through the device mapper and eventually hit blk-mq which
would then handle crypto appropriately.

We couldn't do that because the crypto ciphers for the
blk-crypto-fallback couldn't be allocated on the data path (so we
needed fscrypt to ask blk-crypto to check whether the underlying
device supported the crypto capabilities it required, and
allocate ciphers appropriately, before the data path required the
ciphers). I'm checking to see if anything has changed w.r.t
allocating crypto ciphers on the data path (and checking if
memalloc_noio_save/restore() helps with that).
> - Eric
