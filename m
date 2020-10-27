Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 379E229AA6F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 12:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2899115AbgJ0LSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 07:18:51 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56032 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2895230AbgJ0LSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 07:18:48 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kXN02-0000QK-15; Tue, 27 Oct 2020 11:18:46 +0000
Subject: Re: [PATCH][next] afs: fix a dereference on pointer cell before cell
 is null checked
To:     David Howells <dhowells@redhat.com>
Cc:     linux-afs@lists.infradead.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20201021131133.128016-1-colin.king@canonical.com>
 <3189277.1603796746@warthog.procyon.org.uk>
From:   Colin Ian King <colin.king@canonical.com>
Message-ID: <5f9c89a1-148d-1d19-7da7-c362887c92f1@canonical.com>
Date:   Tue, 27 Oct 2020 11:18:44 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <3189277.1603796746@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/10/2020 11:05, David Howells wrote:
> Colin King <colin.king@canonical.com> wrote:
> 
>> @@ -606,7 +605,7 @@ void afs_unuse_cell(struct afs_net *net, struct afs_cell *cell, enum afs_cell_tr
>>  
>>  	u = atomic_read(&cell->ref);
>>  	a = atomic_dec_return(&cell->active);
>> -	trace_afs_cell(debug_id, u, a, reason);
>> +	trace_afs_cell(cell->debug_id, u, a, reason);
> 
> It's probably better to read cell->debug_id before calling
> atomic_dec_return().
> 
> I have a patch for this based on a report by Dan Carpenter, so no need to send
> a revised patch.

OK - thanks David
> 
> Thanks,
> David
> 

