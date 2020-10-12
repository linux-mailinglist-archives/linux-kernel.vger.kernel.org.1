Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E90CD28C3FF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 23:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729994AbgJLV1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 17:27:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:44020 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726572AbgJLV1U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 17:27:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C7B8EAE37;
        Mon, 12 Oct 2020 21:27:18 +0000 (UTC)
Date:   Mon, 12 Oct 2020 23:27:09 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Mike Travis <mike.travis@hpe.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] x86/platform updates for v5.10
Message-ID: <20201012212709.GM25311@zn.tnic>
References: <20201012101012.GD25311@zn.tnic>
 <CAHk-=wiwBYoAKQ6H=n0ppZfMe6nVDwDw6cruv7jxZZw4XEmUsg@mail.gmail.com>
 <c8cfb3d2-d3c4-6d8d-1dfd-aeb349e26303@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c8cfb3d2-d3c4-6d8d-1dfd-aeb349e26303@hpe.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 02:15:55PM -0700, Mike Travis wrote:
> > Of course, it also looks like that 'uvh_nmi_mmrx_mask' thing is a
> > write-only variable so it doesn't matter, but can we _please_ get this
> > code fixed ASAP?
> 
> Yes, I'll look at it right now.  Thanks.

As this variable is write-only you could simply zap it now with a patch
ontop to fix the build and then introduce it properly later, when you
really need it?

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
