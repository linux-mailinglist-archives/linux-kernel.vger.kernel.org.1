Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 445351AB0B7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 20:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441531AbgDOS31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 14:29:27 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:13293 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438068AbgDOS30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 14:29:26 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e97524a0001>; Wed, 15 Apr 2020 11:28:26 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 15 Apr 2020 11:29:25 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 15 Apr 2020 11:29:25 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 15 Apr
 2020 18:29:24 +0000
Received: from rcampbell-dev.nvidia.com (172.20.13.39) by
 DRHQMAIL107.nvidia.com (10.27.9.16) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Wed, 15 Apr 2020 18:29:24 +0000
Subject: Re: [PATCH] mm/vmsan: Fix some typos in comment
To:     Ethon Paul <ethp@qq.com>, <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20200411071544.16222-1-ethp@qq.com>
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <497dbd84-d542-9b3b-8cde-1a4a21436f40@nvidia.com>
Date:   Wed, 15 Apr 2020 11:29:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200411071544.16222-1-ethp@qq.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1586975306; bh=bhanuAPvHmGQYLbAnacA0iTZn5v9KrMPe1at4Lhwljw=;
        h=X-PGP-Universal:Subject:To:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=cOXDwhxZ+Pl4BQS7AVjF4kgFYvYqTAqT10uyWZVBu11/ogxrIT9YWmT7+zBPIp3gY
         QGc6SQT2wNOIVTvX2sHAAAm2C3uDaWJruaRzbA3WTFDQoYSqdE9UjuQTt/c85ZMxGr
         1wi6UDQb/nKGrT7V4aGbCWYQ5219RFlaKGjvsZXx4zdGjGJm8wyNfnkcz+VriQnpD/
         TPESFPE4f4IfMETtsYjF7guP3sSEIurd4ztRYwUS09buQJ2PcbNsPRjz+C9pVE6Wfh
         ad7OoDXHKLn1XClgV2CVvmMotjaEvSL1ELzX9aqykEz5lz0SwgTmUYF+HZ0qBIZP1e
         gup+QdewHbr+Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/11/20 12:15 AM, Ethon Paul wrote:
> There are some typos, fix them.
> 
> s/regsitration/registration
> s/santity/sanity
> s/decremeting/decrementing
> 
> Signed-off-by: Ethon Paul <ethp@qq.com>

Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>
