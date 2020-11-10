Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1F82AD73F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 14:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731671AbgKJNOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 08:14:37 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:58414 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgKJNOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 08:14:36 -0500
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605014074;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IW9cOAgIqp2aiZ7VDlWPW2DwmFJzPVsCmee9IuyxOJQ=;
        b=OXe6LqMA4M1Rlo3SZSZBlNkrB1dVwsyK1vc/xE320zd/uhGgyTLoK/BMX8Zt45iBfa5S/C
        uuoYMxjfzxPLZYoFIEVbpNfyd/HeXs6rzLRwclmSiZDZbeLumafme4RRIepxWSMYwATsQJ
        VWDKFhOuvxiVOC4NPDVk5CQw8iRUUL1cD9FfJ0IBzsvB+Y/bzqUfXGHtVYJ6fKC9O/+Yxs
        0mno/2P4nFDzyVH65BWhTl9ce8DzwQtiWTloQGdmKk3D83+aJpnryfS5gr8aun6jEe7IfY
        qjPLMQA4g1WU/spJmM0xTKshNSjPKpyPKVWA23OBMCuSuvfEyQvWRNc9Dno6jg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605014074;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IW9cOAgIqp2aiZ7VDlWPW2DwmFJzPVsCmee9IuyxOJQ=;
        b=lASBIaA5znIIjR1seuwRzjiGEgUnP2Gz3AVIC2iETXI3DHaXBR60cVRNiw2IvMcRxKggOi
        /e6zSUUQ3bc7hkCw==
To:     Nikolay Borisov <nborisov@suse.com>, pmladek@suse.com,
        sergey.senozhatsky@gmail.com
Cc:     linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH] printk: ringbuffer: Convert function argument to local variable
In-Reply-To: <20201110125012.353456-1-nborisov@suse.com>
References: <20201110125012.353456-1-nborisov@suse.com>
Date:   Tue, 10 Nov 2020 14:20:34 +0106
Message-ID: <87v9edqrph.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-11-10, Nikolay Borisov <nborisov@suse.com> wrote:
> data_alloc's 2nd argument is always rb::text_data_ring and that functino
> always takes a struct printk_ringbuffer. Instead of passing the data
> ring buffer as an argument simply make it a local variable.

This is a relic of when we had a second data ring (for
dictionaries). The patch is a nice cleanup, but there are actually
several functions that could use this exact same cleanup:

- data_make_reusable()
- data_push_tail()
- data_alloc()
- data_realloc()

Perhaps we should fix them all in a single patch?

John Ogness
