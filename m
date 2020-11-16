Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFD802B3B85
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 03:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbgKPCti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 21:49:38 -0500
Received: from relay68.bu.edu ([128.197.228.73]:46168 "EHLO relay68.bu.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbgKPCti (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 21:49:38 -0500
X-Greylist: delayed 611 seconds by postgrey-1.27 at vger.kernel.org; Sun, 15 Nov 2020 21:49:38 EST
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated bits=0)
        by relay68.bu.edu (8.14.3/8.14.3) with ESMTP id 0AG2ckR6027512
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 15 Nov 2020 21:38:50 -0500
Date:   Sun, 15 Nov 2020 21:38:46 -0500
From:   Alexander Bulekov <alxndr@bu.edu>
To:     Andrey Konovalov <andreyknvl@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Collecting both remote and "local" coverage with KCOV
Message-ID: <20201116023846.awjtbzh2o2yj4fvn@mozz.bu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I'm trying to collect coverage over the syscalls issued by my process,
as well as the kthreads spawned as a result of these syscalls
(eg coverage over vhost ioctls and the worker kthread). Is there a way
to collect coverage with both KCOV_REMOTE_ENABLE(with common_handle) and
KCOV_ENABLE, simultaneously? 

Based on the code it seems that these two modes are mutually
exclusive within a single task, but I don't think this is mentioned in
the Documentation, so I want to make sure I'm not missing something.
Thank you
-Alex
