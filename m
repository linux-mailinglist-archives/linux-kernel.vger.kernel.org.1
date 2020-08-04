Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46D0623B43C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Aug 2020 06:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729663AbgHDEpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Aug 2020 00:45:30 -0400
Received: from mail5.windriver.com ([192.103.53.11]:55664 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726000AbgHDEpa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 00:45:30 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id 0744hTcB002937
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Mon, 3 Aug 2020 21:43:50 -0700
Received: from [128.224.162.157] (128.224.162.157) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server id 14.3.487.0; Mon, 3 Aug 2020
 21:43:24 -0700
Subject: Re: [PATCH] crypto: ccp - zero the cmd data after use it
To:     Herbert Xu <herbert@gondor.apana.org.au>
CC:     Tom Lendacky <thomas.lendacky@amd.com>,
        Gary Hook <gary.hook@amd.com>, David <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200803075858.3561-1-liwei.song@windriver.com>
 <20200803125242.GA7689@gondor.apana.org.au>
 <87ae939b-4983-4e96-cc3d-1aa1d1b3d3ae@windriver.com>
 <20200804040420.GA10850@gondor.apana.org.au>
 <1b6be879-8449-b519-046f-0312e57aa9a4@windriver.com>
 <20200804042215.GA10939@gondor.apana.org.au>
From:   Liwei Song <liwei.song@windriver.com>
Message-ID: <7f5e38f8-c7a4-65c7-647b-749f66ccc48b@windriver.com>
Date:   Tue, 4 Aug 2020 12:43:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200804042215.GA10939@gondor.apana.org.au>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/4/20 12:22, Herbert Xu wrote:
> On Tue, Aug 04, 2020 at 12:20:21PM +0800, Liwei Song wrote:
>>
>> Yes, the other process should do this zero work, but the case I met is
>> this address will appear in the slab_alloc_node() as freelist pointer of slub,
>> and before slub do zero wrok, even kzalloc() doesn't work with this address.
> 
> That would be memory corruption which has nothing to do with your
> patch.  If it is occurring then you should fix the place that is
> corrupting the memory and not work around it like this.

OK, understand, thanks for your suggestion.

Liwei.


> 
> Cheers,
> 
