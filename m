Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1091C028F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Apr 2020 18:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgD3QcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Apr 2020 12:32:16 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:56113 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbgD3QcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 12:32:16 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200430163214euoutp013d43fb6b1be7afb8570f6d0bbcfdc832~Kpf9Pk89g2812028120euoutp01Q
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 16:32:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200430163214euoutp013d43fb6b1be7afb8570f6d0bbcfdc832~Kpf9Pk89g2812028120euoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1588264334;
        bh=LFcm6V8qtVXvQexOictvz9Ik09kFXwdv4ZywOAq81Jk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mtcp7KY5VMS4x4UJFWOefyHov3F6PmCXtX8msTa4/nt7ZiBy58/0wYkhf220EcRIZ
         vYPa0riCZyTDo5xytNtO9v/N8ojP4ZxCti9OST2C5ZetD5Gu4RwDA4e8Bevu+rOAk7
         mb3awwPMU3dFvZnqpO6cYtYLqG76/SZhf1zdlJp0=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200430163214eucas1p24990db031dd7172c02b98e5657f400d9~Kpf88I1RL1130811308eucas1p2l;
        Thu, 30 Apr 2020 16:32:14 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 1D.E8.61286.E8DFAAE5; Thu, 30
        Apr 2020 17:32:14 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200430163213eucas1p2c5c040b5d34cf2f41286b99751df7cb2~Kpf8QxehL1130811308eucas1p2k;
        Thu, 30 Apr 2020 16:32:13 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200430163213eusmtrp2891e1d78639f1be8ecbcddc47f25776e~Kpf8QAPqO1116911169eusmtrp2f;
        Thu, 30 Apr 2020 16:32:13 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-9c-5eaafd8e4e54
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 9F.AB.07950.D8DFAAE5; Thu, 30
        Apr 2020 17:32:13 +0100 (BST)
Received: from localhost (unknown [106.120.51.46]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200430163213eusmtip2b910e8e44cfc63999246899e531558d8~Kpf8FfHlZ1765417654eusmtip2W;
        Thu, 30 Apr 2020 16:32:13 +0000 (GMT)
From:   =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        James Morse <james.morse@arm.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
Subject: [PATCH v2 0/2] Make memory size reporting in kexec_file_load()
 accurate
Date:   Thu, 30 Apr 2020 18:31:40 +0200
Message-Id: <20200430163142.27282-1-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200430105034.17513-1-l.stelmach@samsung.com>
MIME-Version: 1.0
Organization: Samsung R&D Institute Poland
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHfXcuHler1xX4ZJGx7KJQKkqcUMJBH86HPkgUQaE18zRNN2Pz
        kpFYVpJi3ruZ1BxqNsTL1LGmqIzQmbLKUCskS41QTPOSqZi20zHq2+95nv/zf/4vvAwhH6O8
        mThtEq/TqhIUtJS0dC69OpD3yxQVWLdIs12DVootn3xJsXP1qzQ7XZWL2HsNXuxw21MJ+95e
        jVjz6ADFvrWV0Wzl4BsJ29dhkLAr7Usk22i+S7ADH9podnzGQbKL9aNUOOZ+3sojuZrHNYgz
        m7JpbmigleamnE537pO9keQaKzK46bZ+mstrMiFuzryTc9ycpyI2nJaGxfAJcSm8LuDIOWls
        syGfumQiL0/NXyevISuRgzwYwCFgX8pyF1iOqxF8+Lg3B0ldPI/gY451fTCH4N7jiL8L2eWj
        7qLoKYIpx02JWHxFUJvlpAQVjZWQX+n4w1vxewk8MIQLTOAiCVQX+wq8BR+HHwu3/8Qg8R4w
        vWuQCCzDoTCyYkPiNR94dL2HFtgDh0HmXdFfhj2h++EYKfBm7A81mYOk6O8DN5ofEUIgwOUM
        GNpnXKaMqzgKQ9+VoucWmOhqchd5B6w9f7IuyYDiokPiai4CS9kiKWpCYci5TAsaAvtBnS1A
        bCvBONJGi6ub4N03TzHBJiiy3CfEtgxuZ8lFtS/U5reuG3rDnYlqVIAUpf+9pfS//KX/bhkQ
        YUJefLJeo+b1QVo+9aBepdEna9UHzydqzMj193pWu2at6EdftB1hBik2yhizKUpOqVL0aRo7
        AoZQbJV9jnS1ZDGqtCu8LvGsLjmB19vRdoZUeMmCjeORcqxWJfHxPH+J1/2dShgP72vILTU1
        bC6O8Q8peVI3ezG3pXlXfXdByUKHtjchvky5+tAvxmaMbbrgIA/tdktn1s524sCG1+nhZ35W
        bKs7JStcUV51e7Ey/uXZsZ6hzPjJ6BrUG3xy32FllO+MerajP5CZGm45nRZler0c98m4rGwN
        7DxhrCzMVmXsX6A1Gt5SpSD1saogf0KnV/0GD+9izXcDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJIsWRmVeSWpSXmKPExsVy+t/xe7q9f1fFGfRcl7E4fn0Hq8XCN6dY
        LT5v+Mdm8X5ZD6PFtI3iFvf3LWeyuHloBaPFpsfXWC0u75rDZrH0+kUmi0sHFjBZ/Nn/k8Vi
        86apzBbXbu1js3j58QSLxY8Nj1kdBDy+t/axeKyZt4bRY9OqTjaPO9f2sHm8O3eO3ePBoc0s
        HpuX1Hu833eVzaNvyypGj8+b5DxOtHxhDeCO0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHU
        MzQ2j7UyMlXSt7NJSc3JLEst0rdL0MvYuqCftWAVS8W7L40sDYw7mLsYOTkkBEwkOhc+Zu9i
        5OIQEljKKLF2zUyWLkYOoISUxMq56RA1whJ/rnWxQdQ8ZZR4+vEOK0iCTcBRon/pCVaQhIjA
        YyaJpZ92gznMAtOYJA5PWwu2QlggQOL0l8tgHSwCqhKrbmxkArF5BawlHv3ZxQixQl5iduNp
        NhCbU8BGomnqObB6IaCaxvOH2SDqBSVOznwCdh2zgLrE+nlCIGF+AS2JNU3XWUBsZqAxzVtn
        M09gFJqFpGMWQscsJFULGJlXMYqklhbnpucWG+kVJ+YWl+al6yXn525iBEb7tmM/t+xg7HoX
        fIhRgINRiYeXY9OqOCHWxLLiytxDjBIczEoivA9jgUK8KYmVValF+fFFpTmpxYcYTYHenMgs
        JZqcD0xEeSXxhqaG5haWhubG5sZmFkrivB0CB2OEBNITS1KzU1MLUotg+pg4OKUaGG0TXy/y
        nml564TG9acNXzN/HpdL+XrFd/bSXN2lz5d/uBr97NARr1tf1T0X1DxJWCYddcPtjFiYnZ/H
        2Q+m8VofFrOsEuOfemR/RODl1E2pglUnTK7ZvPbbVJC9Uu5PzkYfBvHGQK8HX62+1GkeKmT9
        vpc7v+uZZOmFgAmb+G7de/m/66Pxt2dKLMUZiYZazEXFiQAjkHeDDAMAAA==
X-CMS-MailID: 20200430163213eucas1p2c5c040b5d34cf2f41286b99751df7cb2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200430163213eucas1p2c5c040b5d34cf2f41286b99751df7cb2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200430163213eucas1p2c5c040b5d34cf2f41286b99751df7cb2
References: <20200430105034.17513-1-l.stelmach@samsung.com>
        <CGME20200430163213eucas1p2c5c040b5d34cf2f41286b99751df7cb2@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Calling kexec_add_buffer() page-alligns the value of kbuf.memsz, so it
is not same as the requested value. Hence both bufsz and memsz should
after kexec_add_buffer() is called should be be reported separately.

Łukasz Stelmach (2):
  arm64: kexec_file: print appropriate variable
  x86: kexec_file: print appropriate variable

 arch/arm64/kernel/machine_kexec_file.c | 6 +++---
 arch/x86/kernel/crash.c                | 2 +-
 arch/x86/kernel/kexec-bzimage64.c      | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.25.0

