Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5439C1D7EFA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 May 2020 18:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbgERQo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 May 2020 12:44:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37279 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728519AbgERQo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 12:44:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589820296;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HmKG2XSLE3/J68hgnuYjwER/7zsYr5OkD9knzKGzUfo=;
        b=h1Hrako95ydeUJYJU2z8aYgKAVidahc1fJH3QdqX9l/vLN0bM5vvi8g6i9b9lmU/odSNRO
        OqgYlbrkCSdk9GNpu58HEmOe8BOCpsilpd9nHIRkonBRMb4c/OmesScfWZ90oTkdPJiVeJ
        UYp4fOdL1x596SYSm0MjU95uOFk1Z+U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-b7jxYptWP_K2nQ2-TGriEg-1; Mon, 18 May 2020 12:44:54 -0400
X-MC-Unique: b7jxYptWP_K2nQ2-TGriEg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6410C100A8ED;
        Mon, 18 May 2020 16:44:53 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 65435797E9;
        Mon, 18 May 2020 16:44:50 +0000 (UTC)
Date:   Mon, 18 May 2020 12:44:49 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Alasdair Kergon <agk@redhat.com>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: next-20200514 - build issue in drivers/md/dm-zoned-target.c
Message-ID: <20200518164449.GA24518@redhat.com>
References: <367320.1589627953@turing-police>
 <7bb0d1c8-b164-d5f3-0218-5c71047c3a8c@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7bb0d1c8-b164-d5f3-0218-5c71047c3a8c@suse.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18 2020 at  2:25am -0400,
Hannes Reinecke <hare@suse.de> wrote:

> On 5/16/20 1:19 PM, Valdis Klētnieks wrote:
> >Am seeing a build error in next-0514.  -0420 built OK.
> >building a 'make allmodconfig' on a RPi4 in 32-bit mode.
> >
> >   MODPOST 7575 modules
> >ERROR: modpost: "__aeabi_uldivmod" [drivers/md/dm-zoned.ko] undefined!
> >
> >objdump and 'make drivers/md/dm-zoned-target.s' tells
> >me that the problem is in function dmz_fixup_devices(), near here:
> >
> >@ drivers/md/dm-zoned-target.c:806:             reg_dev->nr_zones = DIV_ROUND_UP(reg_dev->capacity,
> >         ldr     r0, [r6, #56]   @ reg_dev_166->capacity, reg_dev_166->capacity
> >         adds    r1, r3, r1      @ tmp316, _227, reg_dev_166->capacity
> >         adc     r0, r2, r0      @ tmp315, _227, reg_dev_166->capacity
> >         subs    r1, r1, #1      @, tmp316,
> >@ drivers/md/dm-zoned-target.c:805:             reg_dev->zone_nr_sectors = zoned_dev->zone_nr_sectors;
> >         strd    r2, [r6, #80]   @, reg_dev,
> >@ drivers/md/dm-zoned-target.c:806:             reg_dev->nr_zones = DIV_ROUND_UP(reg_dev->capacity,
> >         sbc     r0, r0, #0      @, tmp315,
> >         bl      __aeabi_uldivmod                @
> >@ drivers/md/dm-zoned-target.c:806:             reg_dev->nr_zones = DIV_ROUND_UP(reg_dev->capacity,
> >         str     r1, [r6, #64]   @ tmp306, reg_dev_166->nr_zones
> >
> >git blame points at this commit:
> >
> >commit 70978208ec91d798066f4c291bc98ff914bea222
> >Author: Hannes Reinecke <hare@suse.de>
> >Date:   Mon May 11 10:24:30 2020 +0200
> >
> >     dm zoned: metadata version 2
> >
> >Reverting that commit lets the build complete.
> >
> >
> I thought I've send a patch to fix that up; DIV_ROUND_UP() needs to
> be changed to DIV_ROUND_UP_ULL().
> I'll be checking and will be sending a patch if necessary.

Unless I'm missing something it was fixed up with this commit last
wednesday (13th):

https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=dm-5.8&id=81a3a1453ec4e5da081e1395732801a600feb352


