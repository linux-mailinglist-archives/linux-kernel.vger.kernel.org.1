Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E12F269432
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 19:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725992AbgINRxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 13:53:07 -0400
Received: from kylie.crudebyte.com ([5.189.157.229]:46129 "EHLO
        kylie.crudebyte.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbgINL0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 07:26:54 -0400
X-Greylist: delayed 1200 seconds by postgrey-1.27 at vger.kernel.org; Mon, 14 Sep 2020 07:26:53 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        Content-ID:Content-Description;
        bh=++NQLUetBSLmFRHbsLpXBmOsqS1jQD6y5F/DUjvr1YA=; b=lZv5LqkCfhovigLTtCbuQfQHrI
        2asQqCaFUnWxtpt/IjVaApnvHVg8+nq3bJ/xE26Wz/tpJwE1p7h/fQD8S8EAuXiFHtlYNvqnnTmQD
        mrjOMc/LDfNZZtm8UpFmkeyTG1hVzKVCjERiyn/IHm3b1RDymKHg+wxc2HKTVQhRCkehX5rFFyrgc
        0b849hfad8x+A16WS1a2m2AK5MuxGPwB3t42Vx2CctMkU/3M2w9gA+BoWikepYTo2JVRa8fvpKhiO
        QdzKXdvBKY0yUPaua8LHmgYBoVDKkYkxvDu94l0OVOqXLpJ1oEK1SsLDSOgGWkUw1uBCaF69mK04w
        QPRNgCx/BjqKMfjUlsmR+rY9FXOHmtDjowu91kDU96kXHme3ADrAzlaQ0Knwf08X0ccS3ju1OPR+4
        8UE/OHkiKpZAumQ6koiyDUXjxGz8dWgWtOqtYY/TKZwh8XT3j1x0JQHA2S/jjNgnCu4Eu/T0uX31r
        7mEchOl14EG2a5sp6sNToXRVzbT6AfoHX8vZbrD736wxAWRIfGuYZZVqexS3rnX6GpATwSZvwt9Ar
        LrlR9L4SbfwcmQFHpgVmOQCvHV5lwTHEgThWXAfUqZxqiW4GcaDBKhA4XOhpEbJDDa0Iwrk+ehsdo
        OFX+JnKNjgUqqDSyb+d7ye2F3mvdfqNBS3sY/7AVA=;
From:   Christian Schoenebeck <qemu_oss@crudebyte.com>
To:     Greg Kurz <groug@kaod.org>
Cc:     Jianyong Wu <jianyong.wu@arm.com>, ericvh@gmail.com,
        lucho@ionkov.net, asmadeus@codewreck.org,
        v9fs-developer@lists.sourceforge.net, justin.he@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [V9fs-developer] [PATCH RFC 0/4] 9p: fix open-unlink-f*syscall bug
Date:   Mon, 14 Sep 2020 13:06:34 +0200
Message-ID: <2828347.d8MXItvaOC@silver>
In-Reply-To: <20200914103546.0f775bcd@bahia.lan>
References: <20200914033754.29188-1-jianyong.wu@arm.com> <20200914103546.0f775bcd@bahia.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Montag, 14. September 2020 10:35:46 CEST Greg Kurz wrote:
> On Mon, 14 Sep 2020 11:37:50 +0800
> 
> Jianyong Wu <jianyong.wu@arm.com> wrote:
> > open-unlink-f*syscall bug is a well-known bug in 9p, we try to fix the bug
> > in this patch set.
> > I take Eric's and Greg's patches which constiute the 1/4 - 3/4 of this
> > patch set as the main frame of the solution. In patch 4/4, I fix the fid
> > race issue exists in Greg's patch.
> 
> IIRC some patches were needed on the QEMU side as well... I'm spending
> less time on 9pfs in QEMU, so Cc'ing the new maintainer:
> 
> Christian Schoenebeck <qemu_oss@crudebyte.com>

AFAICS this is about this old bug report:
https://bugs.launchpad.net/qemu/+bug/1336794

So yes, looks like this also requires changes to the 9pfs 'local' fs driver on 
QEMU side:
https://lists.nongnu.org/archive/html/qemu-devel/2016-06/msg07586.html

Eric, Greg, would there be an easy way to establish QEMU test cases running 
the 9pfs 'local' fs driver? Right now we only have 9pfs qtest cases for QEMU 
which can only use the 'synth' driver, which is not helpful for such kind of 
issues.

Best regards,
Christian Schoenebeck


