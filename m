Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFBE2A1A68
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 21:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728546AbgJaUFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 16:05:33 -0400
Received: from mxout03.lancloud.ru ([89.108.73.187]:52772 "EHLO
        mxout03.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728451AbgJaUFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 16:05:33 -0400
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout03.lancloud.ru 2AF34200DF11
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Sergey Shtylyov <s.shtylyov@omprussia.ru>
Subject: [PATCH v2 0/3] module: refactor module_sig_check()
To:     Jessica Yu <jeyu@kernel.org>, <linux-kernel@vger.kernel.org>
Organization: Open Mobile Platform, LLC
CC:     Joe Perches <joe@perches.com>
Message-ID: <22e48a3d-06ee-5b8e-6e56-3694871a7c2f@omprussia.ru>
Date:   Sat, 31 Oct 2020 23:05:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [213.87.129.247]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1908.lancloud.ru (fd00:f066::208)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here are 3 patches against the 'modules-next' branch of Jessica Yu's 'linux.git' repo.
I'm doing some refactoring in module_sig_check()...

[1/3] module: merge repetitive strings in module_sig_check()
[2/3] module: avoid *goto*s in module_sig_check()
[3/3] module: only handle errors with the *switch* statement in module_sig_check()
