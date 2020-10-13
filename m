Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38A7128D571
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 22:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbgJMUix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 16:38:53 -0400
Received: from mxout03.lancloud.ru ([89.108.73.187]:33420 "EHLO
        mxout03.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbgJMUiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 16:38:52 -0400
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout03.lancloud.ru 26310206E800
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Sergey Shtylyov <s.shtylyov@omprussia.ru>
Subject: [PATCH 0/2] module: some refactoring in module_sig_check()
To:     Jessica Yu <jeyu@kernel.org>, <linux-kernel@vger.kernel.org>
Organization: Open Mobile Platform, LLC
Message-ID: <789a4e5c-8efd-bb1c-86e2-eed8b2b7b0af@omprussia.ru>
Date:   Tue, 13 Oct 2020 23:32:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [213.87.131.195]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1908.lancloud.ru (fd00:f066::208)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here are 2 patches against the 'modules-next' branch of Jessica Yu's 'linux.git' repo.
I'm doing some little refactoring in module_sig_check()...

[1/2] module: merge repetitive strings in module_sig_check()
[2/2] module: unindent comments in module_sig_check()
