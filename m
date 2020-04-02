Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D762719C2DD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Apr 2020 15:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388812AbgDBNlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Apr 2020 09:41:39 -0400
Received: from foss.arm.com ([217.140.110.172]:42826 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388789AbgDBNli (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 09:41:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE25B30E;
        Thu,  2 Apr 2020 06:41:37 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.29.153])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BDB133F52E;
        Thu,  2 Apr 2020 06:41:36 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     arnaldo.melo@gmail.com, shikemeng@huawei.com
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        James Clark <james.clark@arm.com>
Subject: [PATCH 0/1] perf tools: fix compilation on Arm
Date:   Thu,  2 Apr 2020 14:41:27 +0100
Message-Id: <20200402134128.14493-1-james.clark@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200330131810.GC31702@kernel.org>
References: <20200330131810.GC31702@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

This patch seems to break the build for me on your
perf/core branch but adding the header fixes it.


Thanks
James

James Clark (1):
  perf tools: fix compilation on Arm

 tools/perf/arch/arm64/util/machine.c | 1 +
 1 file changed, 1 insertion(+)

-- 
2.17.1

