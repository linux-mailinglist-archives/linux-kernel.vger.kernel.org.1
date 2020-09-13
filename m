Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 848482681E1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 01:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbgIMXlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 19:41:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52763 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725942AbgIMXlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 19:41:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600040466;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UJLqcVSZ7pPnISgCDygxTYaoMaPljNSjLbUqnqPIhsQ=;
        b=XsWZhZlTnoLNP9dl0n0kr2yfXun5G3c0D7cFO6kDbqgleh9Td6aR5ksiRRCzPbhEGXCPIv
        G0X2A2Ws9KHJtViFf7tt8vuFUSuvAb15EWYALof0Bgi5qt8tKn4vL6pDiWfi+uZiSPuyFD
        PNk+Vwt9we4CcpkCgX1asHT0yI/LcOM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-hZZMT7qLN3O_-Y7ZZEIiyA-1; Sun, 13 Sep 2020 19:40:59 -0400
X-MC-Unique: hZZMT7qLN3O_-Y7ZZEIiyA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 23B07393B4;
        Sun, 13 Sep 2020 23:40:58 +0000 (UTC)
Received: from [10.64.54.46] (vpn2-54-46.bne.redhat.com [10.64.54.46])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6F1F85C1BB;
        Sun, 13 Sep 2020 23:40:55 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH] arm64/mm: Refactor {pgd, pud, pmd, pte}_ERROR()
To:     kernel test robot <lkp@intel.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, anshuman.khandual@arm.com,
        mark.rutland@arm.com, will@kernel.org, shan.gavin@gmail.com
References: <20200913114430.16102-1-gshan@redhat.com>
 <202009140651.OyF1SCmz%lkp@intel.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <11e1e917-f9ed-e25f-e887-0c4f18231ede@redhat.com>
Date:   Mon, 14 Sep 2020 09:40:52 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <202009140651.OyF1SCmz%lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/14/20 8:19 AM, kernel test robot wrote:
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on arm64/for-next/core]
> [also build test WARNING on soc/for-next kvmarm/next v5.9-rc4 next-20200911]
> [cannot apply to arm/for-next xlnx/master]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Gavin-Shan/arm64-mm-Refactor-pgd-pud-pmd-pte-_ERROR/20200913-194714
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
> config: arm64-defconfig (attached as .config)
> compiler: aarch64-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # save the attached .config to linux build tree
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=arm64
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>     In file included from include/linux/printk.h:7,
>                      from include/linux/kernel.h:15,
>                      from include/asm-generic/bug.h:20,
>                      from arch/arm64/include/asm/bug.h:26,
>                      from include/linux/bug.h:5,
>                      from include/linux/mmdebug.h:5,
>                      from include/linux/mm.h:9,
>                      from include/linux/pagemap.h:8,
>                      from mm/pgtable-generic.c:10:
>     mm/pgtable-generic.c: In function 'pgd_clear_bad':
>     include/linux/kern_levels.h:5:18: warning: format '%lx' expects argument of type 'long unsigned int', but argument 4 has type 'pgdval_t' {aka 'long long unsigned int'} [-Wformat=]

[...]

I'm fixing this by passing "%016llx" instead of "%016lx" to pr_err() in v2.

Thanks,
Gavin

