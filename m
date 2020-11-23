Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79DA12C0EC1
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 16:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389250AbgKWPVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 10:21:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732112AbgKWPVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 10:21:16 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31701C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 07:21:14 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id t9so17480122edq.8
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 07:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WPXUx430LnqQxeTZwzSkDFktxVPqtAT/jaYg4wIZyxk=;
        b=LXm46n5TdR+1xeNouvTvFr1ivS62asPdZdB31bOlVsT5BKzkMj/+bKCD8vhmi50Sku
         2eoPBTwzFBrA8wBznE+v2fxfD9xu2nSv1kwGSaXzWjNxzAbrDx2jm4K32aPRxclB9pb2
         61jOQLmXSUatymax117GMqax06v6MvrgPGizxVDH5pdPyZlN5FsIzlRJ7aZZk9VOGH4/
         zGBztV1cpPlK12uJs5Ja8FCQMfo1Z+I86yIorQTFqs1UQDD3uEIuQQ8GO5w1aJAz3z7h
         cmAq6YPMN8/NfX++e5J00EodQW5PU+a8x+yIABNkidhIdS+2WM3r68qrdFYZ/5OEq/c2
         +cZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WPXUx430LnqQxeTZwzSkDFktxVPqtAT/jaYg4wIZyxk=;
        b=JnoFOQsMlM6Twv85+8jfkqfgUF8wSGDYUCLndxCLVTM8SohZqKJws3pHXCKSQ3Dd25
         sduLd4uj5nXpFC9DuZpOxgqZ6a9gat/jGB9GRqC0x9CsW9rZZ7TOuHYY7t1iArg6JCsE
         Vg8CVSwOjeamSPz/IIvxl4KtSE8l+OqCAyP4ruuj227YFyvBKWA6rHpXmRRAsqGNv+DF
         uAPtZHjQgT3AGxf4+KdCXrvaWdFtUzAzl1ZzHIvpgrKl0nK9JzKBTzRNHP3rvOmBoKIA
         0w7Cf7PprhDRRwrIMwbaLODlQnfx1nqAz0EzYkQq5qhklfI/6OPV1CL/2dWXkhQPujuu
         rHIQ==
X-Gm-Message-State: AOAM533UtUmhzRhqEeJY7yCoBteC/w9bHGaVaWCwYdleO30dvF8qQjYS
        njEPEQFGqNN4Kofz1+9MvYAXAg==
X-Google-Smtp-Source: ABdhPJxhxtt19Z3WtSpCVcK/Ve5s7SmVsOSdHr8q/b2/k07m8/TTAxvA7b2MayacN0xqcxT+5ikbbg==
X-Received: by 2002:a50:ec86:: with SMTP id e6mr34445252edr.111.1606144872749;
        Mon, 23 Nov 2020 07:21:12 -0800 (PST)
Received: from [192.168.0.105] (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id e12sm5221514edm.48.2020.11.23.07.21.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2020 07:21:12 -0800 (PST)
Subject: Re: undefined reference to `start_isolate_page_range'
To:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
References: <202011210906.WVDfrAtS-lkp@intel.com>
 <4860e097-f90e-fdf6-454f-514e4a7c3c68@infradead.org>
From:   Michal Simek <monstr@monstr.eu>
Message-ID: <ee32a1f8-8216-346d-8572-3521b7688db4@monstr.eu>
Date:   Mon, 23 Nov 2020 16:21:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <4860e097-f90e-fdf6-454f-514e4a7c3c68@infradead.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23. 11. 20 2:13, Randy Dunlap wrote:
> On 11/20/20 5:26 PM, kernel test robot wrote:
>> Hi Michal,
>>
>> FYI, the error/warning still remains.
>>
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   4ccf7a01e805f04defd423fb410f47a13af76399
>> commit: 2602276d3d3811b1a48c48113042cd75fcbfc27d microblaze: Wire CMA allocator
>> date:   10 months ago
>> config: microblaze-randconfig-s031-20201121 (attached as .config)
>> compiler: microblaze-linux-gcc (GCC) 9.3.0
>> reproduce:
>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         # apt-get install sparse
>>         # sparse version: v0.6.3-134-gb59dbdaf-dirty
>>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2602276d3d3811b1a48c48113042cd75fcbfc27d
>>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>         git fetch --no-tags linus master
>>         git checkout 2602276d3d3811b1a48c48113042cd75fcbfc27d
>>         # save the attached .config to linux build tree
>>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=microblaze 
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>    microblaze-linux-ld: mm/page_alloc.o: in function `alloc_contig_range':
>>>> (.text+0xa1fc): undefined reference to `start_isolate_page_range'
>>>> microblaze-linux-ld: (.text+0xa40c): undefined reference to `test_pages_isolated'
>>>> microblaze-linux-ld: (.text+0xa47c): undefined reference to `undo_isolate_page_range'
> 
> 
> FTR:  This is a Kconfig problem in drivers/gpu/drm/aspeed/Kconfig
> and it is fixed in linux-next and drm-misc-next.
> 
> https://lore.kernel.org/dri-devel/20201011230131.4922-1-rdunlap@infradead.org/
> 

Thanks for letting me know.
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs

