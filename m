Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5DD1F0055
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jun 2020 21:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbgFETPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Jun 2020 15:15:15 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:39556 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727064AbgFETPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 15:15:14 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Fri, 5 Jun 2020 12:15:10 -0700
Received: from akaher-virtual-machine.eng.vmware.com (unknown [10.197.103.239])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id 35C76B008B;
        Fri,  5 Jun 2020 15:15:14 -0400 (EDT)
From:   Ajay Kaher <akaher@vmware.com>
To:     <fan_yang@sjtu.edu.cn>
CC:     <dan.j.williams@intel.com>, <kirill.shutemov@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <torvalds@linux-foundation.org>,
        <gregkh@linuxfoundation.org>, <srivatsab@vmware.com>,
        <srivatsa@csail.mit.edu>, <akaher@vmware.com>
Subject: Re: [PATCH v3] mm: Fix mremap not considering huge pmd devmap
Date:   Sat, 6 Jun 2020 00:44:36 +0530
Message-ID: <1591384476-31924-1-git-send-email-akaher@vmware.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <B9824572-C3C0-4D3B-88B8-D3A34D645653@sjtu.edu.cn>
References: <B9824572-C3C0-4D3B-88B8-D3A34D645653@sjtu.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-002.vmware.com: akaher@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Fan, this scenario works to reproduce on v4.9.

And following fix works for v4.9:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?h=linux-4.9.y&id=44cb51d5b4a736446b728bbde8407844d71843ef

-Ajay 

