Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 879791E9A71
	for <lists+linux-kernel@lfdr.de>; Sun, 31 May 2020 23:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbgEaVGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 May 2020 17:06:55 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:15033 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbgEaVGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 17:06:55 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ed41c100000>; Sun, 31 May 2020 14:05:21 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 31 May 2020 14:06:55 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 31 May 2020 14:06:55 -0700
Received: from [10.2.56.10] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 31 May
 2020 21:06:47 +0000
Subject: Re: [PATCH 0/2] video: fbdev: fix error handling, convert to
 pin_user_pages*()
To:     Sam Ravnborg <sam@ravnborg.org>
CC:     LKML <linux-kernel@vger.kernel.org>, <linux-fbdev@vger.kernel.org>,
        "Arnd Bergmann" <arnd@arndb.de>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        <dri-devel@lists.freedesktop.org>
References: <20200522041506.39638-1-jhubbard@nvidia.com>
 <20200531205819.GC138722@ravnborg.org>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <854fae07-3cb4-dbcf-fa93-35b447f9d084@nvidia.com>
Date:   Sun, 31 May 2020 14:06:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200531205819.GC138722@ravnborg.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1590959121; bh=/ZGiEKiwNpXWSWZDwVkz+Tk/sHOOPYcqnJuRlZIDyZ8=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=pqjPHdWkXaeLqCJnJg2hyDItqsOnTLmyv6+3NdUBHO6w+yJcUKJKTnJsg1MOxJFRn
         FvmOxEZbBzjv7u6M4gELvw/CHGhtD/e968J/WBj9G2F8GLhX8z1vsHgUwpG/ZYSDjZ
         OCdaZ97vkDpYFLZOvw6aTxGRB/RxsaHmMZHOuXBo6QgiG5q4VGjbO/abFzW51wXnH0
         xhNVv0KY7++eiLqrNMD7NVVzlkM5396UFNSvBOgJt2XZN1ivoBmjw0LjFZHQefPPrq
         wIxAr3F9wGCBMKLAnRBeWUWS0lXLDREWRZgO9StI8+TrFbcRYaHauuoQR1mgoQseEx
         8RuTEf7qBXQ8g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-31 13:58, Sam Ravnborg wrote:
...
> Thanks, patches are now applied to drm-misc-next.
> They will hit -next soon, but you will have to wait
> until next (not the upcoming) merge window before they hit
> mainline linux.
> 
> 	Sam
> 

Great! That will work out just fine.


thanks,
-- 
John Hubbard
NVIDIA
