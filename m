Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4B452A0C21
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 18:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbgJ3RJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 13:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727267AbgJ3RJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 13:09:18 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69DFC0613D2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 10:09:16 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id 1so3263039ple.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 10:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=910WvRONJI7sMb4xpMJyZRy4K33DbUTdlqxf8AIGpUw=;
        b=EoecKjImrBskaCUS70NmrLIvyf6eVkez5Ql0jqwreVYGInDHmVdE6sbXtzVqxR9CLg
         GUrCrWbyWbflW/PSZB7FKPGdXDtmiQP8v+pCOqrWuL1gxybNgAIEZSRPV+ir0Jko3cdS
         jNdKGDmKSvV/sb4FLhHbaDrkVQg5LZj8Wd0eeuy72j9NuXh8BNlRrTJtShVE1ZEy/g2/
         jrc3vvZlJ1YiIOj7lMZ9Rxmly9TMajsntOgJvTqDOyrrLbZfI2h6c3Ot8Kcjf+YoYXL3
         RGFjmDWj5qIHRCFN0qFU3KKzvON++GMnrEiXI/8LuueHXCxuldzCTECk4s9+1AEegKOY
         L1xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=910WvRONJI7sMb4xpMJyZRy4K33DbUTdlqxf8AIGpUw=;
        b=OOp/mN0GqeCK9cFPWOsyt0NwqOQGPWpKOYUGc2K4Kk0+G0/BPWZ78B6KbnFmH5x887
         IHQQnkMS2DrTHpbgDltjONAdM+y7ku0dJntAExUJqQz+6n1sOciYVroFDkSl/+xJcpJT
         tM/fYRXsrg6OidCPqA0SVAFFL+OPOzIi1ein/ptARIP+HALsM49LWjDo55i19J60Q+q3
         Qc813SWMt2NkPUD92CKunrDsP65EBCAnF+dqYmeAMrXds3fRRGwCBKk3+Ed906An4XBJ
         W4Y/8dinJsrcfbat0WjkZnjlhB+vS4faQFXVRIjMl57JryRWCTGkCReHncLLMbd/e52/
         I1ug==
X-Gm-Message-State: AOAM5325vlpPe2zHzbgvcTLS7+1b69Ww801ykvBBfQoOZIzzweimh5qf
        i+5+ucYZcc2vi4sGPTpbndIBqOPzpzRj4Q==
X-Google-Smtp-Source: ABdhPJylISIfTFWeh9ADTXHddUZK2hUz0oYUW6sO9TtblxDUxDWhL0rQ22r9QrXCQOUfdC83NZPKpg==
X-Received: by 2002:a17:902:7685:b029:d6:65a6:c70b with SMTP id m5-20020a1709027685b02900d665a6c70bmr9501461pll.30.1604077754654;
        Fri, 30 Oct 2020 10:09:14 -0700 (PDT)
Received: from ?IPv6:2620:10d:c085:21cf::1547? ([2620:10d:c090:400::5:15c3])
        by smtp.gmail.com with ESMTPSA id c10sm6304825pfc.196.2020.10.30.10.09.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2020 10:09:14 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     io-uring <io-uring@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] io_uring fixes for 5.10-rc
Message-ID: <394acda8-6cce-3cc9-5b5e-6b6f13851ef6@kernel.dk>
Date:   Fri, 30 Oct 2020 11:09:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Fixes that should go into this release:

- Fixes for linked timeouts (Pavel)

- Set IO_WQ_WORK_CONCURRENT early for async offload (Pavel)

- Two minor simplifications that make the code easier to read and follow
  (Pavel)

Please pull!


The following changes since commit ee6e00c868221f5f7d0b6eb4e8379a148e26bc20:

  splice: change exported internal do_splice() helper to take kernel offset (2020-10-22 14:15:51 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/io_uring-5.10-2020-10-30

for you to fetch changes up to c8b5e2600a2cfa1cdfbecf151afd67aee227381d:

  io_uring: use type appropriate io_kiocb handler for double poll (2020-10-25 13:53:26 -0600)

----------------------------------------------------------------
io_uring-5.10-2020-10-30

----------------------------------------------------------------
Jens Axboe (1):
      io_uring: use type appropriate io_kiocb handler for double poll

Pavel Begunkov (7):
      io_uring: remove opcode check on ltimeout kill
      io_uring: don't adjust LINK_HEAD in cancel ltimeout
      io_uring: always clear LINK_TIMEOUT after cancel
      io_uring: don't defer put of cancelled ltimeout
      io_uring: don't miss setting IO_WQ_WORK_CONCURRENT
      io_uring: simplify nxt propagation in io_queue_sqe
      io_uring: simplify __io_queue_sqe()

 fs/io_uring.c | 108 +++++++++++++++++++++-------------------------------------
 1 file changed, 38 insertions(+), 70 deletions(-)
-- 
Jens Axboe

