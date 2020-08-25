Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C52952519EC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Aug 2020 15:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbgHYNlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Aug 2020 09:41:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:54162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726158AbgHYNks (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 09:40:48 -0400
Received: from [10.44.0.192] (unknown [103.48.210.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F0772076C;
        Tue, 25 Aug 2020 13:40:45 +0000 (UTC)
From:   Greg Ungerer <gerg@linux-m68k.org>
Subject: [git pull] m68knommu changes for v5.9-rc3
To:     torvalds@linux-foundation.org
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux/m68k <linux-m68k@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Message-ID: <97069a5f-fd94-8a75-3fc6-3e50f7e3ec3a@linux-m68k.org>
Date:   Tue, 25 Aug 2020 23:40:42 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the m68knommu changes for v5.9-rc3.
Only a single fix for the binfmt_flat loader (reverting a recent change).

Regards
Greg



The following changes since commit d012a7190fc1fd72ed48911e77ca97ba4521bccd:

   Linux 5.9-rc2 (2020-08-23 14:08:43 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git tags/m68knommu-for-v5.9-rc3

for you to fetch changes up to 2217b982624680d19a80ebb4600d05c8586c4f96:

   binfmt_flat: revert "binfmt_flat: don't offset the data start" (2020-08-24 08:49:13 +1000)

----------------------------------------------------------------
m68knommu: fixes for 5.9-rc3

Fixes include:
. revert binfmt_flat data offset removal

----------------------------------------------------------------
Max Filippov (1):
       binfmt_flat: revert "binfmt_flat: don't offset the data start"

  fs/binfmt_flat.c | 20 ++++++++++++--------
  1 file changed, 12 insertions(+), 8 deletions(-)
