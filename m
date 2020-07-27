Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3019D22E7CF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jul 2020 10:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbgG0Iej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jul 2020 04:34:39 -0400
Received: from outbound1mad.lav.puc.rediris.es ([130.206.19.137]:60518 "EHLO
        mx01.puc.rediris.es" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726227AbgG0Iej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 04:34:39 -0400
X-Greylist: delayed 642 seconds by postgrey-1.27 at vger.kernel.org; Mon, 27 Jul 2020 04:34:38 EDT
Received: from mta-out02.sim.rediris.es (mta-out02.sim.rediris.es [130.206.24.44])
        by mx01.puc.rediris.es  with ESMTP id 06R8Nclx000553-06R8Ncm1000553
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 27 Jul 2020 10:23:38 +0200
Received: from mta-out02.sim.rediris.es (localhost.localdomain [127.0.0.1])
        by mta-out02.sim.rediris.es (Postfix) with ESMTPS id F263AC143E2;
        Mon, 27 Jul 2020 10:23:37 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mta-out02.sim.rediris.es (Postfix) with ESMTP id 9E3D9C143E5;
        Mon, 27 Jul 2020 10:23:37 +0200 (CEST)
X-Amavis-Modified: Mail body modified (using disclaimer) -
        mta-out02.sim.rediris.es
Received: from mta-out02.sim.rediris.es ([127.0.0.1])
        by localhost (mta-out02.sim.rediris.es [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id uzO0DVWZRF3N; Mon, 27 Jul 2020 10:23:37 +0200 (CEST)
Received: from lt-gp.iram.es (75.red-88-27-245.staticip.rima-tde.net [88.27.245.75])
        by mta-out02.sim.rediris.es (Postfix) with ESMTPA id F2D9CC143E2;
        Mon, 27 Jul 2020 10:23:35 +0200 (CEST)
Date:   Mon, 27 Jul 2020 10:23:31 +0200
From:   Gabriel Paubert <paubert@iram.es>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
        dja@axtens.net
Subject: Re: [PATCH v2 2/5] powerpc: Allow 4224 bytes of stack expansion for
 the signal frame
Message-ID: <20200727082331.GA2110@lt-gp.iram.es>
References: <20200724092528.1578671-1-mpe@ellerman.id.au>
 <20200724092528.1578671-2-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724092528.1578671-2-mpe@ellerman.id.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=iram.es; s=DKIM; c=relaxed/relaxed;
 h=date:from:to:cc:subject:message-id:references:mime-version:content-type;
 bh=1ZiclzWz6oRLNeIZ15slU/UsF+W9BEH+Xsbw5PctIeE=;
 b=AVE2V79dBHbGgXqjCH0Kp156+jzlwPfSIyCjGr6Gtf4dw7kS/LpXXwsmne4zYQ5FBqsbd+3q/s5y
        JvlpRRdehpXLSBWzkgtmf5caJJvqbUHvrCFykvs9JpJEyOvE/hzs71VhQbJiTwTwfoXhuZK/jr6w
        FjWQFPU6BkL7q17HUxt9y9PRhQUN1hMYi2oR+Mgi+fAwQLEy/sM4JycmET/8I/mGsVgnpzHTyx8t
        RnHFFXFvaSDEylntHhb0rPl3L6FrgzKHk0iU/5g9WS9ZGY7qG4pNNEwza+nxYA00El9rcC0gUr+y
        /l+hJUkZluc9lLyLD2PpSEkZ1rToQES3GKFrGg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 07:25:25PM +1000, Michael Ellerman wrote:
> We have powerpc specific logic in our page fault handling to decide if
> an access to an unmapped address below the stack pointer should expand
> the stack VMA.
> 
> The code was originally added in 2004 "ported from 2.4". The rough
> logic is that the stack is allowed to grow to 1MB with no extra
> checking. Over 1MB the access must be within 2048 bytes of the stack
> pointer, or be from a user instruction that updates the stack pointer.
> 
> The 2048 byte allowance below the stack pointer is there to cover the
> 288 byte "red zone" as well as the "about 1.5kB" needed by the signal
> delivery code.
> 
> Unfortunately since then the signal frame has expanded, and is now
> 4224 bytes on 64-bit kernels with transactional memory enabled.

Are there really users of transactional memory in the wild? 

Just asking because Power10 removes TM, and Power9 has had some issues
with it AFAICT.

Getting rid of it (if possible) would result in smaller signal frames,
with simpler signal delivery code (probably slightly faster also).

	Gabriel
 

