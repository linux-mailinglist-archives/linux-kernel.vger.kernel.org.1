Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3050C2DCEA3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 10:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbgLQJor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 04:44:47 -0500
Received: from www381.your-server.de ([78.46.137.84]:56898 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgLQJor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 04:44:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=HHNhKphKZ5QqF9WjO51pWepbtNuJwsgWw1Hcw6UPKx4=; b=GN3BTU0INkArDmJZ3aQuHEzafd
        zzhThECDD6GFVc960TCPKNU7Qg7akHdoXRH9RU1oZ4+KoqkDNKkT78LI5BIVfgTAJl1WnNF28PlU8
        lpKfJ8MZCK4UVYrCZ5dRpQrmEQgwPXLvYCJp0cIYrTSYPcmvQWcXLPnH0OOjjt4zB3N34Nnq3jiiv
        8en6UD52X1B2UkTnVpoWT6PfG5dxj6+efCdoabxlmyBfKiXCgDYZDMkZvB2pm+n0drNaA7wfABJoS
        OTVl/QXy/IrMnyL67Ax6WrCqMqllyqyJEd/AJdmPN6Z957FyPseIymgV5c93+3FIv95RnezqR89Um
        NXan7Xsw==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1kppp3-0000rs-QS; Thu, 17 Dec 2020 10:43:46 +0100
Received: from [62.216.202.54] (helo=[192.168.178.20])
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1kppp3-000DPQ-Ie; Thu, 17 Dec 2020 10:43:45 +0100
Subject: Re: [PATCH v1 ] ALSA: core: memalloc: add page alignment for iram
To:     Robin Gong <yibin.gong@nxp.com>, perex@perex.cz, tiwai@suse.com,
        akpm@linux-foundation.org, xiang@kernel.org,
        pierre-louis.bossart@linux.intel.com, gustavoars@kernel.org,
        shengjiu.wang@nxp.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <1608221747-3474-1-git-send-email-yibin.gong@nxp.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <05c824e5-0c33-4182-26fa-b116a42b10d6@metafoo.de>
Date:   Thu, 17 Dec 2020 10:43:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <1608221747-3474-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/26019/Wed Dec 16 15:36:02 2020)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/17/20 5:15 PM, Robin Gong wrote:
> Since mmap for userspace is based on page alignment, add page alignment
> for iram alloc from pool, otherwise, some good data located in the same
> page of dmab->area maybe touched wrongly by userspace like pulseaudio.
>
I wonder, do we also have to align size to be a multiple of PAGE_SIZE to 
avoid leaking unrelated data?

