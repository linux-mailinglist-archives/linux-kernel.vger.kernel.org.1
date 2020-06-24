Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79C4B20700A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jun 2020 11:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389657AbgFXJ3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jun 2020 05:29:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:39754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388336AbgFXJ3w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 05:29:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3737D20857;
        Wed, 24 Jun 2020 09:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592990991;
        bh=o8Wph+So75oI/F7OPTg6XWFj9P7CXmEWmmnGKYyDUJI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HVacYQmFlK7ihe4yQ1EQnDH096602cBbZIObeyph6W4qQdOFjLCP5APTDCD48iEAO
         KwLoiZ+kiblJ3pKG5qFipJLeC8JOnYa+GXXa37oHqcWrnRVYdNt8jbNWn5DxxEOa7/
         9cV9dT7ekyYvbvIYdaDRweGvCPcjNOCBuk90MABo=
Date:   Wed, 24 Jun 2020 11:29:50 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Zhang, Qiang" <Qiang.Zhang@windriver.com>
Cc:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>
Subject: Re: =?utf-8?B?5Zue5aSNOiBbUEFUQ0hdIHVzYjog?= =?utf-8?Q?gadget?=
 =?utf-8?Q?=3A?= function: printer: Add gadget dev interface status judgment
Message-ID: <20200624092950.GA1751086@kroah.com>
References: <20200615094608.26179-1-qiang.zhang@windriver.com>
 <BYAPR11MB26324BC70657061DA849A384FF950@BYAPR11MB2632.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR11MB26324BC70657061DA849A384FF950@BYAPR11MB2632.namprd11.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 08:59:40AM +0000, Zhang, Qiang wrote:
> Hello, Greg KH
> Please have you review the patch?

I am not the gadget driver maintainer :)

Give Felipe a chance to catch up...

greg k-h
