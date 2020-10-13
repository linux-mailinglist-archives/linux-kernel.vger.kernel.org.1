Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A15128CC51
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 13:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388866AbgJMLME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 07:12:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:50256 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388056AbgJMLMD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 07:12:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9A132B20D;
        Tue, 13 Oct 2020 11:12:02 +0000 (UTC)
Date:   Tue, 13 Oct 2020 13:11:58 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Mike Travis <mike.travis@hpe.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] x86/platform updates for v5.10
Message-ID: <20201013111158.GD32151@zn.tnic>
References: <20201012101012.GD25311@zn.tnic>
 <CAHk-=wiwBYoAKQ6H=n0ppZfMe6nVDwDw6cruv7jxZZw4XEmUsg@mail.gmail.com>
 <c8cfb3d2-d3c4-6d8d-1dfd-aeb349e26303@hpe.com>
 <20201012212709.GM25311@zn.tnic>
 <f778b25e-68e7-98ec-9032-b35696948405@hpe.com>
 <d865e9cd-38c9-2210-116b-935336a3738f@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d865e9cd-38c9-2210-116b-935336a3738f@hpe.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 02:58:07PM -0700, Mike Travis wrote:
> I was in the process of tracing it through and perhaps it does need a bit
> more analysis to be correct.  What does it mean to send a patch to fix the
> compile error, just remove it?

Yes, to remove it for now as it is unused currently. But making it an
unsigned long is ok too AFAICT. So should I queue it and send it to
Linus later?

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
