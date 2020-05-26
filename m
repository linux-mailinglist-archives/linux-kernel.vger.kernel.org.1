Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 042531A8EAC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 00:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392017AbgDNWeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 18:34:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23334 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387731AbgDNWeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 18:34:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586903644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XvrH3IAsWSFzjHPgpGENW0nsL1zyORYzUOddXMqBgts=;
        b=DaA+9kPL5/mIZSJj4S/sYfgS9hLgBtLMku44N9NOCQMlIoWM685rrFGyF2KyaoVqf6ZnZN
        c25RNpqI31XO9hraYFdwQTGnMWTuMIBSaQheo9qDs91+q0t7QJ/7sezzJf1gea2kWLByr0
        dB6ZaTsOE6S//3OXA49Fq+67z1lu9Jg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-465-SmfKKYzJPByNsj6uQwfD_A-1; Tue, 14 Apr 2020 18:34:02 -0400
X-MC-Unique: SmfKKYzJPByNsj6uQwfD_A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2E7CB8017F6;
        Tue, 14 Apr 2020 22:34:01 +0000 (UTC)
Received: from treble (ovpn-116-146.rdu2.redhat.com [10.10.116.146])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3BC3D5D9E5;
        Tue, 14 Apr 2020 22:34:00 +0000 (UTC)
Date:   Tue, 14 Apr 2020 17:33:57 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     peterz@infradead.org, mingo@kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] objtool: Remove redundant section name comparison
Message-ID: <20200414223357.tbc66fdok5nxb4if@treble>
References: <20200412144405.4423-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200412144405.4423-1-songmuchun@bytedance.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 12, 2020 at 10:44:05PM +0800, Muchun Song wrote:
> If the prefix of section name is not '.rodata', the following
> function call can never return 0.
> 
>     strcmp(sec->name, C_JUMP_TABLE_SECTION)
> 
> So the name comparison is pointless, just remove it.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Thanks, added to the queue.

-- 
Josh

