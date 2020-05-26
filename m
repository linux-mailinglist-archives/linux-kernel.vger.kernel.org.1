Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5B2D1B5B0C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Apr 2020 14:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbgDWMFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Apr 2020 08:05:11 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:56260 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728104AbgDWMFL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 08:05:11 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 638CE4A17C;
        Thu, 23 Apr 2020 12:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        in-reply-to:content-disposition:content-type:content-type
        :mime-version:references:message-id:subject:subject:from:from
        :date:date:received:received:received; s=mta-01; t=1587643507;
         x=1589457908; bh=mLLyssSl6nMcwXw59jsI5OboKUUNH5MjP+qTGX8gHHs=; b=
        OY75G05PhSzt2UMWkl7XrxyvffrzW9M7VFST76ZgRkVMRyvdWRRiIrU6Km5QujVE
        /2sJ4v4XTFJIfhs3z/DzvRxYnDtID4Y68+4b3BXPVnjZmJ3qRdgG2r7ywY8/XBds
        VRdNIfnCpEwfipWFSeELQreZh+FUrLtgQQvuKTxj6zw=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id SGlfKVfQBJWF; Thu, 23 Apr 2020 15:05:07 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 5106B46473;
        Thu, 23 Apr 2020 15:05:07 +0300 (MSK)
Received: from localhost (172.17.14.122) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Thu, 23
 Apr 2020 15:05:08 +0300
Date:   Thu, 23 Apr 2020 15:05:06 +0300
From:   "Alexander A. Filippov" <a.filippov@yadro.com>
To:     Alexander Filippov <a.filippov@yadro.com>
CC:     <linux-aspeed@lists.ozlabs.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Joel Stanley <joel@jms.id.au>, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] ARM: DTS: Aspeed: Add YADRO Nicole BMC
Message-ID: <20200423120506.GA21043@bbwork.lan>
References: <20200423112100.19424-1-a.filippov@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20200423112100.19424-1-a.filippov@yadro.com>
X-Originating-IP: [172.17.14.122]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like I've missed subject prefix.
Should I resend this with v4 prefix?

Alexander
