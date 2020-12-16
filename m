Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4B9D2DBF2B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 12:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbgLPLDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 06:03:40 -0500
Received: from mout.gmx.net ([212.227.15.15]:37061 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbgLPLDk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 06:03:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1608116527;
        bh=O/LvRBAa7QWGElvpU5tXUaVKIHRXyE5A2MjBT+9nh5k=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date;
        b=JJGo0kvDMSNybEzuxXvjTsO2If/m4pb10EFQfQ7lWWPGIkorbS13ZAgbQGdqoKmja
         N5PHHZXZKvHNt/Z80L8HRgaWN3dKAlJNwE4HjhSMI4l8LALWIV4EmGB+xhXd/4ffJC
         lmjpk/P+bA3sKC+30TLrCA9Z2eNIw/wtLQA1TvgU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.217.61]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mqb1W-1kKXWx2ZHM-00mX8Y; Wed, 16
 Dec 2020 12:02:07 +0100
Message-ID: <7b13506084a015d0256222cdd278fe461cdd4a74.camel@gmx.de>
Subject: regression: 9a56493f6942 "uts: Use generic ns_common::count" broke
 makedumpfile 1.6.7
From:   Mike Galbraith <efault@gmx.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>
Date:   Wed, 16 Dec 2020 12:02:06 +0100
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:NCKxONUyBbguT6F//ZxpKZx+MdXWrMlqiGcfcXy6RIC0heRiESD
 5zj40QLZYXwfKmzHQRlBhOw+7CVh345Anf2Q4ysp6EVzuuAAjVYIqGXZlRa4+53jTTxPNik
 BbmKnnPvOxYxvMXEU0Wr/9vP5lZhrO+/c7a+VzDxWU5VCT/jWScd8UDHfKBMPVp9uHDwS8F
 Cf2iuTmuTa3GAk3mgp6rA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:CEnK2dW8Mk0=:qLp52nCQAR1sXpcyr/J0YJ
 /+TMCnvsE4dvPgbrBBxg7+fogV+vUx+fwPnTlI5WyTSGgyf325G9fhcH6mszSPm2klvSXzyO+
 JwPwAgseldx4vIokCHLb4Rn3rp77yw0yE5Ybi24acdofqgn5h4GLTFK6CaYThpVSfVXHF3G5J
 sL1Cd2DPdv2jKmqLqEpSg0x8SQ4VcTwP5fAxLSR6D5W5Blt5fZjhiJ0KhWf6PzhwCrhgUSk2U
 11G/pSuQVy3fYZHCR6PreSy7xxC5bRFnXCf/rpabY6q+uklranpxMFNEBPVJi1qgVNWkwiQNi
 3lMvKkt1t9Mf0soucOvqM+XvmJMtqlkIvcrsTNDuYrgNb2234zTwyBZPjpIkgSkiCdpk3Ng11
 gOzWcqLrm66Z8T5tBXL7Q/cUbw70pAM5x2GJs6zlxjRzQQYx2ptGQjmRd+HHn6lH7LtjUszF4
 I5jiwIbgUGCWr81wQiRgnwhExBox6fmAnb/Ph8uwEAAMb/eakb2HwZ2neHfQCFBXtQ6h3VBJO
 LprP34gFgfe7NyMBrJ0Mcu35uRvUsL5WiEpQvxk8yYWQ2Z8Sfxc+htBbc0RnD57Qg0laoirIK
 0ndZI6RaLzoRB51KQFFX1zwIq8kyLhWsuLPWiT1sgITb7qfNYEcR04rQUOAqqbXWZP2aeENoC
 4cjYzo8gRaZVsDAcjBRKY7r/sw59a4AyLrN3Y1RfG6+OjBcuUr9lWeKPCJRh1XA+G/qawUWa/
 k9g1rBN7e2vF1k5ZS5DE8C9nsIgMlWdV3jSf2A6BFgd2Bq8+Osv/6kLyZixuKypTjDRyL58c4
 d8SUFMAn5Rf2TIf6M9FHXfcB/wG/p2W+sTsOMHSUWFSXKHotLoS0Uvfg6gldX3uD05Ff16K7A
 hWDCnf1VzQEwssEFKIZw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

With this commit, bisected and confirmed, kdump stops working here,
makedumpfile saying "check_release: Can't get the kernel version".

	-Mike

