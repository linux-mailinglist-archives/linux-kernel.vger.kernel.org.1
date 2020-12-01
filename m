Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3E512CA74D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 16:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391930AbgLAPkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 10:40:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391563AbgLAPkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 10:40:47 -0500
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3BAC0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 07:40:06 -0800 (PST)
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 29740C009; Tue,  1 Dec 2020 16:40:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1606837205; bh=GoRwIwonAOU1Q5PokVg4Jw2hvJ7Uen6eODPUPTDWBsw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a91gR3o5zarCtnU2Ikl2WiUlVy/+sJQanroKYqVUEMnAcWoCHTWsNf1fNiupZib7e
         wVEcGRRiEpL7xBeZNXzrl9BlvdM44V8tuKOIhHTuSS37ChVLJ8P2jBpBVN2rm2Q+KQ
         SJTYPktxWUY05qNAER+/7EiBY4LlpactC+Ldsw1i/exRkUFSTVFbYxSStbIdnb3AUA
         rsIECmjCLseY1kJVBxdVHfLQb1T44nTxDj5wfRU0gSYireS8ezLfCVWb9lc9Y0+SjI
         0vKY7Xj64TgL+qUk50pp3hmzNwM+nfQ4586EPwPhWf29M5wpohgJcrkkDdHmJKqEU4
         NgdbhPy+UXpiA==
Date:   Tue, 1 Dec 2020 16:39:50 +0100
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc:     Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net
Subject: Re: [V9fs-developer] [PATCH] fs: 9p: add generic splice_read file
 operations
Message-ID: <20201201153950.GA20545@nautica>
References: <20201201135409.55510-1-toke@redhat.com>
 <20201201145728.GA11144@nautica>
 <20201201151658.GA13180@nautica>
 <87mtyx1rem.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87mtyx1rem.fsf@toke.dk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Toke Høiland-Jørgensen wrote on Tue, Dec 01, 2020:
> > This made me test copy_file_range, and it works with both as well (used
> > not to)
> >
> > interestingly on older kernels this came as default somehow? I have
> > splice working on 5.4.67 :/ so this broke somewhat recently...
> 
> Huh, no idea; this is my first time digging into filesystem code, I
> normally do networking and BPF :)

In case anyone else wants to know, this broke in 5.10-rc1 with
36e2c7421f02 ("fs: don't allow splice read/write without explicit ops")

So really a recent regression, good catch :)

-- 
Dominique
