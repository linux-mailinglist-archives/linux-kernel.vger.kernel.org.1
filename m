Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0C82B69E1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 17:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbgKQQTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 11:19:17 -0500
Received: from m12-14.163.com ([220.181.12.14]:48052 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726532AbgKQQTQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 11:19:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=I3ifv
        WZR1lbHRhanY9ZS1xhRW1COxPF6zdD6wkNw6a8=; b=oOvfo4ZVIc8iRWTzoIrgT
        DkZ7GK+HN5Jx0qNBxqszE8GmsJ1MJpBfOvOSKcpds+5tW3VQw++MmkBdABge3RCP
        JCSixFfKofJheQbUfjYaAbpolqpVqd2i2LLLgaoKlymk4q6/skCum+AUSDuFNLsK
        H22c6xN27VLVoRE2vTdl0k=
Received: from localhost (unknown [101.86.213.141])
        by smtp10 (Coremail) with SMTP id DsCowABXzbFD97Nfrq1AWQ--.48674S2;
        Wed, 18 Nov 2020 00:16:03 +0800 (CST)
Date:   Wed, 18 Nov 2020 00:16:03 +0800
From:   Hui Su <sh_def@163.com>
To:     tglx@linutronix.de, christian.brauner@ubuntu.com, serge@hallyn.com,
        avagin@openvz.org, 0x7f454c46@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] namespace: make timens_on_fork() return nothing
Message-ID: <20201117161603.GA45032@rlk>
References: <20201117161447.GA44938@rlk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117161447.GA44938@rlk>
X-CM-TRANSID: DsCowABXzbFD97Nfrq1AWQ--.48674S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU0ksgUUUUU
X-Originating-IP: [101.86.213.141]
X-CM-SenderInfo: xvkbvvri6rljoofrz/1tbiJgPfX1v2fByMlgAAsy
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please ignore this change.

