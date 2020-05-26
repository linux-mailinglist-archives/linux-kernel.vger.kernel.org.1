Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6F471CD38C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 May 2020 10:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728817AbgEKIMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 04:12:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:40664 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726319AbgEKIMI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 04:12:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6E202ADC2;
        Mon, 11 May 2020 08:12:09 +0000 (UTC)
Subject: Re: [PATCH] xen-platform: Constify dev_pm_ops
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        boris.ostrovsky@oracle.com, sstabellini@kernel.org
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
References: <20200509134755.15038-1-rikard.falkeborn@gmail.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <03d892fb-eb90-19e1-9d23-71d4b9df75ff@suse.com>
Date:   Mon, 11 May 2020 10:12:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200509134755.15038-1-rikard.falkeborn@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.05.20 15:47, Rikard Falkeborn wrote:
> dev_pm_ops is never modified, so mark it const to allow the compiler to
> put it in read-only memory.
> 
> Before:
>     text    data     bss     dec     hex filename
>     2457    1668     256    4381    111d drivers/xen/platform-pci.o
> 
> After:
>     text    data     bss     dec     hex filename
>     2681    1444     256    4381    111d drivers/xen/platform-pci.o
> 
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen
