Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D502021551B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jul 2020 12:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728448AbgGFKG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jul 2020 06:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728264AbgGFKG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 06:06:28 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F5FC061794
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 03:06:28 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id k15so22201316lfc.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 03:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VIy1PYFvSGV4F/y0iGsUNRz/f+oDEDfZZt7Xzd1mAQw=;
        b=aZOSy7jO/RQMl3lqs6m9IcJVXUAAa3tjv9H9pSIm0grp0B35UwL8mtd69hePoWofuz
         M5C6MVjlDmSI7x/dOKmKkAABK/LnK8HEJ4ShXaQeiph6ye9diF8guf0qNu7xqZmfoXyl
         zbgB+BnZx9gS8a3rJ74IiVxp7pLVJdmCo43frloEsrcZiod4TAYoDZlekkCkjcxgV64J
         9HoKzMWND4+xK63KzI+IEwUc/12vhLOSXKI9/uStvVKc9w6U3DfTI3BcbueRI9B3z0Ll
         2Cm72ARNpUpoV1AOiGQVtSyi0LJGYb7xqUj/jJIZvfNGazCTaiCJDTJqP9FgB/0GIpsN
         munw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VIy1PYFvSGV4F/y0iGsUNRz/f+oDEDfZZt7Xzd1mAQw=;
        b=Sz11vNVC4P/3pR74LYGYjEVJ2JU9RGP3OD/1I+W2TgEDX/iLaUBH5UwlmyMPOAzLjB
         88SQWBJhofxg6s9EWVPcRZx1T5fTW8pf1dZQOFO/j3TcHLd0734LgpHNdb7vfg9eKsMM
         l+atSdc/HrABT4B81tP+RaaWOmQ2Xhu3YO7BioLQDnda+zzxVZs9rI1CmQELowxdMhh9
         gFUNcZjbpBevx++Qzaq/OHigQVwaAiI2kluaNyN1SluKhj3UlWlfGuMkC/zx29jOfKQv
         Yz26oOnAAKWMJZdOU1mlWvMD+65DP1zbtY074T+vvpdGmIu7nOys+ny4CIiRAOPNUTXG
         o4yA==
X-Gm-Message-State: AOAM53332Y5uQbjzK1t7RUUXLmZmjzggTPKnoe6K3tqr6xDCfnMjGBgS
        96+mIOAlTwuD0u6VHj8Wg9ssYg==
X-Google-Smtp-Source: ABdhPJzT2D7wioGEbB2zTH7RUm4yrbl9kADwLsMGQa9kouT4Ky4/Ih+Ee54x09/RRzXMGgC3fuDRAw==
X-Received: by 2002:ac2:4422:: with SMTP id w2mr29362578lfl.152.1594029986326;
        Mon, 06 Jul 2020 03:06:26 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id m9sm8811917lfb.5.2020.07.06.03.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 03:06:25 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id D810310220C; Mon,  6 Jul 2020 13:06:25 +0300 (+03)
Date:   Mon, 6 Jul 2020 13:06:25 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Wei Yang <richard.weiyang@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        yang.shi@linux.alibaba.com, vbabka@suse.cz, willy@infradead.org,
        thomas_os@shipmail.org, thellstrom@vmware.com,
        anshuman.khandual@arm.com, sean.j.christopherson@intel.com,
        aneesh.kumar@linux.ibm.com, peterx@redhat.com, walken@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, digetx@gmail.com
Subject: Re: [RESEND Patch v2 1/4] mm/mremap: format the check in
 move_normal_pmd() same as move_huge_pmd()
Message-ID: <20200706100625.nxh5hd4m6rremzyt@box>
References: <20200626135216.24314-1-richard.weiyang@linux.alibaba.com>
 <20200626135216.24314-2-richard.weiyang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626135216.24314-2-richard.weiyang@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 09:52:13PM +0800, Wei Yang wrote:
> No functional change, just improve the readability and prepare for
> following cleanup.

It's pretty much redundant. It doesn't provide any meaningful
readability improvement. Please drop the patch.

-- 
 Kirill A. Shutemov
