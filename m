Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 523C727AFFF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 16:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgI1Oa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 10:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbgI1Oa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 10:30:59 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1620BC061755
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 07:30:59 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id u3so763853pjr.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 07:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:mime-version:content-disposition
         :user-agent;
        bh=tkVRzGgszHQV7eGse09dB4I+IO6Y4Orz5Jc7w6yFI10=;
        b=IhAwEaThErLoT5e5otiJDtSSjarndyelOAhDvcL4EGtGojhkadyyZpFsywywUahC5l
         T0wsJ2pbLIr5+np9BZKZUDUqmsPjhJQAwfs3eZD7yjexwfLPazAknPg5t2CXI/NudpGN
         WQc5klQw0RGhPyDwzz9ZQmvZ5+0c/z+ikzzWmk+MDNUyYzBMiZSvLn5N9OJjXq3M+yPG
         CFi/tgs0lNiLwlhBfarF5lcVhSUTJRQACpkWQBRc5Vmx4zGk6s7k0/h3Iw4lodHG42J8
         QZlIMO6IRT4fyrMGHGhxPWnpKsqP68nLwdvyeCw54WljVFbjbFqz3kq+fktbjucIIGHj
         9alQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:mime-version
         :content-disposition:user-agent;
        bh=tkVRzGgszHQV7eGse09dB4I+IO6Y4Orz5Jc7w6yFI10=;
        b=Rvs+z1hkNB66WVfFFQ2Zt7aXNmW+my8EmDcNqepyIXHHLzzwQ9VggyL13C/zs9ZWiK
         rWJVjaWg8Rm2xD/Rmg1+Lolakdy8JY+5ZoIcxCFcKEtJQ74rEme07j/8JbZkukXfaDSP
         +EKeda2FY5gy6k9OT0wFgBmbYVc8NqjNDWUhYzsW6BefydCCEIbYoBlVXUN032IKAIIU
         H/W+CVqfYYokklIwXZ4QXgL4cENDrU444lcO6uRprXz9EoAfjrJfyWKvVTJqUY1qAp42
         JP2yXuJdmiUG9WC/kiL2jYQxRvSHK5YfYI9ARLH2v+B0vE/fPqGGyPHXb3LP6Z+Knhj7
         Nbdw==
X-Gm-Message-State: AOAM533W/GMwJH1uvA9EFxA8Ll7eE2cBdk6HjuB7wxEz/F8s9F1dHUsT
        TAXo6njjjOIOaQ+a9pGQcMo=
X-Google-Smtp-Source: ABdhPJwuMK9EqG3Cw7tmLqWdmhq8wBPklPnsNL+x8Hw+OyGrly4gy4XH7gz7hHJq0+N8e3GxMLbT5g==
X-Received: by 2002:a17:90a:e549:: with SMTP id ei9mr1586450pjb.52.1601303458680;
        Mon, 28 Sep 2020 07:30:58 -0700 (PDT)
Received: from haolee.github.io ([2600:3c01::f03c:91ff:fe02:b162])
        by smtp.gmail.com with ESMTPSA id c3sm1947236pfo.120.2020.09.28.07.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 07:30:58 -0700 (PDT)
Date:   Mon, 28 Sep 2020 14:30:56 +0000
From:   Hao Lee <haolee.swjtu@gmail.com>
To:     npiggin@gmail.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Message-ID: <20200928143056.GA2162@haolee.github.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dan.j.wiilliams@intel.com
Bcc: 
Subject: Can we remove the checking of CONFIG_ARCH_HAS_PTE_SPECIAL in
 __vm_insert_mixed?
Reply-To: 

In the current code, if the architecture supports PTE_SPECIAL,
__vm_insert_mixed() becomes a simple encapsulation of insert_pfn()
because it always calls insert_pfn() and never calls insert_page(). This
behavior is inconsistent with the function's name. As described in
commit 423bad600443 ("mm: add vm_insert_mixed"), this function is
designed to supports _both_ raw pfns and pfns with struct page, but in
architecture with PTE_SPECIAL, it treats the latter as the former. So, I
think we'd better remove the checking of CONFIG_ARCH_HAS_PTE_SPECIAL to
make the behavior consistent for all architectures. If my understanding
is right, I can submit a patch to fix this. Thanks.

Regards,
Hao Lee
