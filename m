Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA1A32927E1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 15:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbgJSNGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 09:06:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:57470 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726336AbgJSNGj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 09:06:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603112798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=67anET1QIVAw8PGuoKV0jgAb85p9V9aPY7HbWEgrbgM=;
        b=noHyyocaqDpI/sEGx2l/xuLEhYEFzDh40rGduuiAe0QW/iZdvA0Ax/FPPprACgxLV2tQBH
        WyUjxBd9HdjFpFut9cVq4BbT5/gJBnKyR864qOgQQxha/PZ9Km1I9liOWBelJBaZEMloV7
        FBkHkgUfcCH7O248e2HKkUxQeFdaJ/w=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7A974AC97;
        Mon, 19 Oct 2020 13:06:38 +0000 (UTC)
Date:   Mon, 19 Oct 2020 15:06:37 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     pintu@codeaurora.org
Cc:     willy@infradead.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, linux-mm@kvack.org, pintu.ping@gmail.com
Subject: Re: [PATCH] mm/util.c: Add error logs for commitment overflow
Message-ID: <20201019130637.GJ27114@dhcp22.suse.cz>
References: <1601639861-32171-1-git-send-email-pintu@codeaurora.org>
 <20201002121726.GF4555@dhcp22.suse.cz>
 <adaf346febe6bb6fbdcedb8709e35bcb@codeaurora.org>
 <20201005072011.GP4555@dhcp22.suse.cz>
 <0e9255fcac61ae6ce90bbdde6421b148@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e9255fcac61ae6ce90bbdde6421b148@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 19-10-20 08:32:34, pintu@codeaurora.org wrote:
[...]
> b) This can be invoked from many places so we are adding the logging at
> wrong layer?
> If so, any other better places which can be explored?

dup_mmap?

> c) Adding logging at kernel layer is not the right approach to tackle this
> problem ?
> 
> d) Another thing we can do is, update the man page with more detailed
> information about this commitment overflow ?

This is a good thing in general

> e) May be returning ENOMEM (Cannot allocate memory) from VM path is slightly
> misleading for user space folks even though there are enough memory?
> => Either we can introduce ENOVMEM (Cannot create virtual memory mapping)
> => Or, update the documentation with approach to further debug this issue?

No, it is close to impossible to add a new error code for interface that
is used so heavily.

-- 
Michal Hocko
SUSE Labs
