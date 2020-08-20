Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4263324C302
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Aug 2020 18:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729590AbgHTQMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Aug 2020 12:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728047AbgHTQMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 12:12:02 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4511DC061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 09:12:02 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id i19so1210658lfj.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 09:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=JbSGQO40xt92EFRCLhkmqCsZNi+2XT9KfIijjTP3Jg1un13cbxU0RJWm0ccE4jrExG
         3yUhzFnitJ7johK6vSfjtdtPP9FY6p7VCcXNlPo0Fu0/VK4dvzmQUIoiNSIpuR9OvznT
         NlhuTRRngtKcUlHGGXODgcKX3SSxk/r9krrEC45m5XEfZDXevXmMoGosPbJ/jBcj0UHC
         h+0h3UmPU74UquVqxYsJG3+csCQJ8PCSno95xpMxTXlgJjeY1jAA3wkJbLOr6ghY1xZE
         8TEfH6Z2RreWs644EMX1IrB1VzAMB62xBMHGkqmdLnBT8f6DjY+CJ0a0gfquASl3uYeM
         I4gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=Rmxw7WHmmmZ/M4UapBsn6kNUksYg0hZchwTV7o1y/23mds3ONCEVtdrXdP/4qcqH+b
         t3e1vXESagBBaMTRHFF+LFdVgTweJfpdeVHJiTZxIScogTF3v9AwCHCVb5bofbMQI0tb
         jy/SGJ5SRJc5SJLdWni0wnmhhRgZe8Y6Uork8NOvkENL8Qht0Bt1ZYM2te4qAuPEmi/p
         s0c6QQkCggV8adg8aV/7NMO1b+MUiNmuC4Ja1Zd4LL9NXdQgjkijRMHBzDGrSpDC7l/i
         q1WmIhDdVFY61+kknO6SbQE3hwdmi0RVADFOtO9fEGwNWU5zc2vUf8ftEp1i8GykumKZ
         rl1Q==
X-Gm-Message-State: AOAM532kKCp+Ct51rg/vspp9HgBnDw+fKGvMtxGlDcWJHqgI4LMkMNCN
        L+B/2zk9l5m/cE3vESmaylKUFUmkBBDy+jfdOw==
X-Google-Smtp-Source: ABdhPJzn5vpDiUZsFZMpUk+6IGUAhwR1P8cYQje1E+jl51ReRV2XeworqzHaRlAQbGb2l5PTkUL8s4AH3eOGiqT7Xzw=
X-Received: by 2002:ac2:5f48:: with SMTP id 8mr1934444lfz.157.1597939920620;
 Thu, 20 Aug 2020 09:12:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:6308:0:0:0:0:0 with HTTP; Thu, 20 Aug 2020 09:12:00
 -0700 (PDT)
Reply-To: angelacoulibaly5@gmail.com
From:   Angela Coulibaly <lorir609@gmail.com>
Date:   Thu, 20 Aug 2020 17:12:00 +0100
Message-ID: <CALAkwiW-mv296gCXKy0CvuqrscrL7JMUEC8yt7VtMdQFG1Zcxw@mail.gmail.com>
Subject: =?UTF-8?B?576O5aW955qE5LiA5aSp77yB5oKo55yL5Yiw5oiR5Y+R6YCB57uZ5oKo55qE5raI5oGv?=
        =?UTF-8?B?5LqG5ZCX77yf?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


