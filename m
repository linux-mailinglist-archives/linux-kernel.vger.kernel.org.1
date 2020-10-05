Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C88FF2831D7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 10:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbgJEIW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 04:22:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:59560 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725885AbgJEIWz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 04:22:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601886174;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aI/dA/YyB11Cz/SfAvKDlYSavn3LBvxcaaExPJKre2I=;
        b=NtxVFlQdoje0yt5u3Pybg9HVbK9tu7yz/O58LoQe+D1NJUg7pjyV8G8iYIauicgt1OESJH
        Fkquj1+MRZBlqS94+Yg1l5hDxCid2lp5C94+Lv4Z2x/q+ANS5/sD6yhwgH0YdIwJ8JBSbD
        /NVLL0AVEjQ3manT2FomzwcDHB7+kdc=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6E7C6AF99;
        Mon,  5 Oct 2020 08:22:54 +0000 (UTC)
Date:   Mon, 5 Oct 2020 10:22:52 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: optionally disable brk()
Message-ID: <20201005082239.GQ4555@dhcp22.suse.cz>
References: <20201002171921.3053-1-toiwoton@gmail.com>
 <653873ef-2a57-37e0-1ac3-fba763652b35@redhat.com>
 <2a0f5ade-d770-c36e-50bc-ff0c8e9dacbf@gmail.com>
 <20201005061248.GN4555@dhcp22.suse.cz>
 <7d7b1ac5-d6a7-5e43-8fb8-12b844d7f501@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d7b1ac5-d6a7-5e43-8fb8-12b844d7f501@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 05-10-20 11:11:35, Topi Miettinen wrote:
[...]
> I think hardened, security oriented systems should disable brk() completely
> because it will increase the randomization of the process address space
> (ASLR). This wouldn't be a good option to enable for systems where maximum
> compatibility with legacy software is more important than any hardening.

I believe we already do have means to filter syscalls from userspace for
security hardened environements. Or is there any reason to duplicate
that and control during the configuration time?
-- 
Michal Hocko
SUSE Labs
