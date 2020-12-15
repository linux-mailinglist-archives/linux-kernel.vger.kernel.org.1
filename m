Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB2712DAE28
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 14:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728694AbgLONk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 08:40:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:55304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727925AbgLONkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 08:40:11 -0500
Date:   Tue, 15 Dec 2020 10:39:44 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608039571;
        bh=n1Y12IPuz8WsBnrwJuGQFrYwwxg9rQjCXiDQppu+wkE=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=qjtQu6P+aaEl9KttbH4+bhBs6ONNnjaqVAzVSDp/JjjME1MD2t1dL0nEiRYE9OjXb
         sRLh/1upAFV/lXrdapEbsNvbjOu0j7TztLDZBerQfIrT/wBT6sUpQpVxeorIBLhT7i
         HwFphB+M2PGCkue0vLx2PatBhxtQynf98oNdpMOXX8mcGVr+GApZCoKJz8Q92qijnJ
         qdrMySWxZsgf7nsM5yl7LxPxKEnyh1UeIrKN2wfILj8Sb9RYmzt8zlHtLtiI1gMcoU
         yb3GQx5Qa1WjRj63DH/zUw9uxcilCg30cJdVRRYoisdRvtweWlno9V56w3cfH9OEm3
         xnjEwP/PwAcCg==
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>
Subject: Re: [PATCH v2] perf callchain: Return directly when use
 '--call-graph dwarf' under !HAVE_DWARF_SUPPORT
Message-ID: <20201215133944.GC252952@kernel.org>
References: <1607996131-9340-1-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1607996131-9340-1-git-send-email-yangtiezhu@loongson.cn>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Dec 15, 2020 at 09:35:31AM +0800, Tiezhu Yang escreveu:
> DWARF register mappings have not been defined for some architectures,
> at least for mips, so we can print an error message and then return
> directly when use '--call-graph dwarf'.
> 
> E.g. without this patch:


Thanks, applied.

- Arnaldo

