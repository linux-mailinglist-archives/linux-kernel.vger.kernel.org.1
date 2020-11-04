Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 385332A6EC4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 21:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731910AbgKDUdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 15:33:43 -0500
Received: from mxout03.lancloud.ru ([89.108.73.187]:33142 "EHLO
        mxout03.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728607AbgKDUdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 15:33:42 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout03.lancloud.ru 96113206E802
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Sergey Shtylyov <s.shtylyov@omprussia.ru>
Subject: [PATCH 0/2] module: add/fix 'kernel-doc' comments
To:     Jessica Yu <jeyu@kernel.org>, <linux-kernel@vger.kernel.org>
Organization: Open Mobile Platform, LLC
Message-ID: <8fe9a7be-9f32-6724-a20f-9659b418f184@omprussia.ru>
Date:   Wed, 4 Nov 2020 23:33:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [213.87.161.212]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1908.lancloud.ru (fd00:f066::208)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here are 2 patches against the 'modules-next' branch of Jessica Yu's 'linux.git' repo.
I'm cleaning up the 'kernel-doc' function comments...

[1/2] module: fix up 'kernel-doc' comments
[2/2] module: add more 'kernel-doc' comments
