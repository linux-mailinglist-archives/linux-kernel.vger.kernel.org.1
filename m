Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25BB4244EE6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Aug 2020 21:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbgHNTkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Aug 2020 15:40:46 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38618 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbgHNTkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 15:40:46 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597434044;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6zOkEf9s44H/bnmcpictIYV+L8o/UXIP9H7RtAFTky4=;
        b=DljsqiVxUuI6gssRPtgrSJZru3j5BonXagEiOip/1xm80qvW31sdEmIoxGXWGW6tiOoy7V
        YxFKtsdFrCvUjENFuCRoi7GbrCx/4ugDEvebheF0+BGZlYV3oIKfOVZpaa0ziT6nkT/UC2
        3vpKf7e5oe3uqpJijB0F7zdkGUTiLjzX85P8oD0h4qLV251A6fp1pVB2zz5rgo0vcyPJ6Y
        YWYjvlVBvhdDhjAPhyqY4samTj5eWeIdhgt2vGGMZ21eWh//tuUbzaX0yemQBpZX8iZBQO
        JYuWcaKiy0Uo/xYlHzHywLOmRQhxSosbXySbluupeq58jiEGGvE/HQjHvQUZzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597434044;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6zOkEf9s44H/bnmcpictIYV+L8o/UXIP9H7RtAFTky4=;
        b=Uu0jFtprWhz2a1FDTAt3DE+3yO56eBwUgar05Nu0kgL64Xnr8MDk8lk/70tatiGHIx83b3
        0D2NFkz3aQzWrrCw==
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Jan Kara <jack@suse.cz>, Nicolas Palix <nicolas.palix@imag.fr>
Subject: Re: fs/ocfs2/suballoc.c:2430:2-8: preceding lock on line 2413
In-Reply-To: <alpine.DEB.2.22.394.2008142059190.2441@hadrien>
References: <202008141412.mP88ccpD%lkp@intel.com> <878sehl5e4.fsf@nanos.tec.linutronix.de> <alpine.DEB.2.22.394.2008142059190.2441@hadrien>
Date:   Fri, 14 Aug 2020 21:40:43 +0200
Message-ID: <87364pkock.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Julia,

On Fri, Aug 14 2020 at 21:00, Julia Lawall wrote:
> On Fri, 14 Aug 2020, Thomas Gleixner wrote:
>> That's clearly a false positive. Is there anything what can be done to
>> help that cocci script here?
>
> I have a better version that needs to get pushed.
>
> But normally these pass through me.  Did you get it directly from kbuild?

Yes, because I touched the affected lines last :)

Thanks,

        tglx
