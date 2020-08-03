Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B255239F8C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Aug 2020 08:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbgHCGTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Aug 2020 02:19:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:60868 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725980AbgHCGTQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 02:19:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4A084AF38;
        Mon,  3 Aug 2020 06:19:30 +0000 (UTC)
Subject: Re: [PATCH v3 3/4] Revert "xen/balloon: Fix crash when ballooning on
 x86 32 bit PAE"
To:     Roger Pau Monne <roger.pau@citrix.com>,
        linux-kernel@vger.kernel.org
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org
References: <20200727091342.52325-1-roger.pau@citrix.com>
 <20200727091342.52325-4-roger.pau@citrix.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <cb9783d8-ba48-f290-95b5-adbdb3900cfd@suse.com>
Date:   Mon, 3 Aug 2020 08:19:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200727091342.52325-4-roger.pau@citrix.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.07.20 11:13, Roger Pau Monne wrote:
> This reverts commit dfd74a1edfaba5864276a2859190a8d242d18952.
> 
> This has been fixed by commit dca4436d1cf9e0d237c which added the out
> of bounds check to __add_memory, so that trying to add blocks past
> MAX_PHYSMEM_BITS will fail.
> 
> Note the check in the Xen balloon driver was bogus anyway, as it
> checked the start address of the resource, but it should instead test
> the end address to assert the whole resource falls below
> MAX_PHYSMEM_BITS.
> 
> Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
> Reviewed-by: Juergen Gross <jgross@suse.com>

Pushed to: xen/tip.git for-linus-5.9


Juergen
