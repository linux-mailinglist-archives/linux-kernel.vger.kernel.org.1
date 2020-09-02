Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFDA25A8A5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Sep 2020 11:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbgIBJcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Sep 2020 05:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbgIBJc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 05:32:29 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6DF3C061244;
        Wed,  2 Sep 2020 02:32:29 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id np15so1945805pjb.0;
        Wed, 02 Sep 2020 02:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=AP4GIrttqKmha4FiSPfcLXZSRJr3ax9khNPBb2oxr68=;
        b=h2CCmqA07O1bHhaypQFI/bi3tYl8u6LMvY0m54AwPEes2ctdO65tDrLeQlhN1j4LmR
         IOzVn5xWKBkJ7bOrM08d4OMUpNHw0ijDaD0lcPy//8zMz4W77lXziuydkpSbw/P1cEKt
         v57JlEnnnTBtfCxf6mz+oDE3NXMG6TiBUNqnlZ1k6GRs7zLow9zYisZtGp5GnMVRJqCY
         vKpsAbSoV9d+WudDmeQ7gURL/L2f6q6+QG8PlfBkC8MMH+RoyIA6pinBHArCJEOMRWan
         ACCzR+GkH6fpzoruxSCPICxuQsF+71uYlqABO0iuTvNE8/nTRF04PWamASd9zS/c7x2O
         kHGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AP4GIrttqKmha4FiSPfcLXZSRJr3ax9khNPBb2oxr68=;
        b=flI8rouXEgZ9yZ7kJzVr8AerjxUhzplD9XzNh7wk8N8s11xMfLNV9KlsJU38GqFOgL
         XYpvO/kpPryPWuREWZjPgt663BhU1NxpgAvq5LXz08jWOPgS4B38hGvpqDBP/W7wzEw7
         zuIEsLPvo/9Gm3bN1YF3Rz4nKcr9yhb28GLPsv/YgJbQC9HEWe+crev7DZ77xyoVA0L7
         OABc5vPFqNmWDM+WRffmGioDCltO7plWVFy8DaJttn+Ns+11Fco++m+3JbeGMFEF1lmB
         BVdAMLDRiF1fbpQib6jbqs+JiRMPfRiudoRYe1qmSsVN5pkg9aqB8Rvggw7aY872HPGz
         s2aw==
X-Gm-Message-State: AOAM532Lc91DM+Dgh3CEfyJGWs/BBPl/KdZgaa3wpe1sNydEteUbJscP
        Zn1D79B7KFY+ynXkEc3SmA==
X-Google-Smtp-Source: ABdhPJyr/vwCvmpj2Bwem63GrX5mcZpO2zT8XXJ/L2HDIQKGBLAyn+mkTc0SO49lssi3A5M9Ih5ZrQ==
X-Received: by 2002:a17:90b:209:: with SMTP id fy9mr1480221pjb.189.1599039148994;
        Wed, 02 Sep 2020 02:32:28 -0700 (PDT)
Received: from localhost.localdomain ([161.117.80.159])
        by smtp.gmail.com with ESMTPSA id m25sm4859286pfa.32.2020.09.02.02.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 02:32:28 -0700 (PDT)
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     hdanton@sina.com, axboe@kernel.dk, hch@lst.de, jack@suse.cz,
        johannes.thumshirn@wdc.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: use-after-free Read in bdev_del_partition
Date:   Wed,  2 Sep 2020 05:31:43 -0400
Message-Id: <20200902093143.610218-1-yepeilin.cs@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <000000000000520ffc05ae2f4fee@google.com>
References: <000000000000520ffc05ae2f4fee@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have sent a patch which reverts cddae808aeb7 ("block: pass a
hd_struct to delete_partition") to syzbot, and it is now pending for
testing:

Link: https://groups.google.com/g/syzkaller-bugs/c/fnk0t9aqhDw/m/FO46-S8XAgAJ

Thank you,
Peilin Ye
