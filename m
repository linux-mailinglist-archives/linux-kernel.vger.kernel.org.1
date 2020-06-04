Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09D941EEA30
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jun 2020 20:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730725AbgFDSYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jun 2020 14:24:42 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:31132 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730714AbgFDSYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 14:24:41 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Thu, 4 Jun 2020 11:24:38 -0700
Received: from akaher-virtual-machine.eng.vmware.com (unknown [10.197.103.239])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 210EF402C6;
        Thu,  4 Jun 2020 11:24:41 -0700 (PDT)
From:   Ajay Kaher <akaher@vmware.com>
To:     <fan_yang@sjtu.edu.cn>
CC:     <dan.j.williams@intel.com>, <kirill.shutemov@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <torvalds@linux-foundation.org>,
        <gregkh@linuxfoundation.org>, <srivatsab@vmware.com>,
        <srivatsa@csail.mit.edu>, <akaher@vmware.com>
Subject: [PATCH v3] mm: Fix mremap not considering huge pmd devmap
Date:   Thu, 4 Jun 2020 23:53:45 +0530
Message-ID: <1591295025-1080-1-git-send-email-akaher@vmware.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <FB4049FE-AC4A-4B13-B39D-B96393EFCCB8@sjtu.edu.cn>
References: <FB4049FE-AC4A-4B13-B39D-B96393EFCCB8@sjtu.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (EX13-EDG-OU-002.vmware.com: akaher@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fan,

Able to reproduce this issue on v4.19.y using your test program.

And as per commit message it fixes commit 5c7fb56e5e3f 
("mm, dax: dax-pmd vs thp-pmd vs hugetlbfs-pm”) at kernel version v4.5.
So, v4.9.y should be vulnerable, however not able to reproduce on v4.9.y.
Does any specific scenerio need to test for v4.9.y?

For v4.9, modified test program as MAP_SHARED_VALIDATE is not available:
- return mmap(NULL, REGION_PM_SIZE, PROT, MAP_SHARED_VALIDATE|MAP_SYNC,
+ return mmap(NULL, REGION_PM_SIZE, PROT, MAP_SHARED|MAP_SYNC,

Let me know if I need to test some other way for v4.9.y.

-Ajay 

