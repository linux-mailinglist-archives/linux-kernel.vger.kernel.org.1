Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE16D27B217
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 18:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgI1Qla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 12:41:30 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39910 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbgI1Ql3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 12:41:29 -0400
Date:   Mon, 28 Sep 2020 18:41:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601311287;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GAgEtkWOwW2XJjw9x5CH75TnzqewgBMgplMvDXtZOUg=;
        b=U9roYUn5oRUKLV98VFKLQRDZa2THE0tI/VxOfDcoZob8aEtU+uK8X6mad6XoV+4lOUEL6S
        ZenvgWtZBjBkFq2G8h/KUMAcgl+xK5QAgS6Dc2L7CUDvMxpdj8TYIbb8SyolvaDWLuhPhF
        tsUdWWnsQlxoAQdikJ1LkIK72C96XBLvuw/NeAn3JaDpFopiHWfh0bhbwyuB2FRbZm6FD8
        ywpby40K8i/3gpwjtW306ebO6MuyqoWOH1Ec4iMhzdqcdrsdP4xu1fWcoW7sSy5tntol+E
        2fdGmM33cBaXP3al8YQBklOFbvxW7r3IUZhKAnZS2mRqbvu4RcZjdmpv5GmniQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601311287;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GAgEtkWOwW2XJjw9x5CH75TnzqewgBMgplMvDXtZOUg=;
        b=9muHe3UOQGOo71zVollt05yEo3qA2Dmg3FJhXmwRWLZu5JDPa+6CRABDbPi0jA8RrCBjTx
        CNkdQjaRUfvFpfAg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Brad Harper <bjharper@gmail.com>
Cc:     linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/1] mmc: host: meson-gx-mmc: fix possible deadlock
 condition for preempt_rt
Message-ID: <20200928164126.57bszuobd5tt4xdu@linutronix.de>
References: <20200927025418.12382-1-bjharper@gmail.com>
 <20200927025418.12382-2-bjharper@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200927025418.12382-2-bjharper@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-26 22:54:18 [-0400], Brad Harper wrote:
> ---

What happens if you boot this on a non-RT kernel with the `threadirqs'
command line option?

Sebastian
