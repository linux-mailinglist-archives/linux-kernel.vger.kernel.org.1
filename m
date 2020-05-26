Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A26041C3E33
	for <lists+linux-kernel@lfdr.de>; Mon,  4 May 2020 17:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729517AbgEDPK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 May 2020 11:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726509AbgEDPKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 11:10:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE31CC061A0E;
        Mon,  4 May 2020 08:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/5CyeOhM27U5uv4E/drHzMGguStn+cxzIB+16o/6zyc=; b=HL3ZRQjsjfv9XvM4tccsYrUYzy
        3Uune7ovqt7E0cLyxeioyOIhR9CDkQZUEWDZnNWOPgg6Tx8IHmzbfd1GGPplVxxGE7x2vi48rRGe5
        dfgBxy++PXbalKb5he1Ndtw4wgQuEQIoHLoewTLXdT6bZz+sTri/pn6hqe5yzIwPuR67bqx57I5M6
        q/MtwI4TVXQaUBWuXwz6cJ80ZEbZklbJ6X5GYbAvY7zG7y7UaW6angseiHHw7Vzeug5NX+6lyf9G8
        HOmWLGyh53wqDX1XPW+9+MJNgcLVnBmtGkATN4iqhMytP/3awX9HFN3OtzgoZOrWlGLvkGt0WyolM
        Y2FJYJKg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jVck8-0000Bx-7h; Mon, 04 May 2020 15:10:52 +0000
Date:   Mon, 4 May 2020 08:10:52 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Christoph Lameter <cl@linux.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 2/4] block/part_stat: use __this_cpu_add() instead of
 access by smp_processor_id()
Message-ID: <20200504151052.GA25279@infradead.org>
References: <158859896942.19836.15240144203131230746.stgit@buzz>
 <158859897252.19836.5614675872684760741.stgit@buzz>
 <20200504140317.GB29020@infradead.org>
 <2dfaeec5-135e-c7ac-714b-ecdf14478568@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2dfaeec5-135e-c7ac-714b-ecdf14478568@yandex-team.ru>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 04, 2020 at 06:02:28PM +0300, Konstantin Khlebnikov wrote:
> Then all per-cpu macro should work as is for UP case too.
> Surprisingly arrow operator (struct->filed) works for arrays too =)
> 
> 
> Inlining per-cpu structures should be good for tiny UP systems.
> Especially if this could be done by few macro only in three places:
> definition, allocating and freeing.

Or we could just use the percpu ops always, which is what most
users do.  I never really go the UP microoptmization here.
