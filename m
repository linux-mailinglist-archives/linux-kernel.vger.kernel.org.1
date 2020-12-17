Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB422DD519
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 17:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbgLQQWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 11:22:44 -0500
Received: from mout.gmx.net ([212.227.17.22]:56915 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725468AbgLQQWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 11:22:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1608222064;
        bh=GiA3SVJQxbWUZvTzL7A9ussr290uZsz9k9rPQnz6TTY=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=e7Jkfv4rwu+0P4AwRO0ZOs/0gSIpd3OMDgN+clRWB2tuFWr/PvsKea7EoqhTCJECh
         VAOn+YHOXFfDixHIubZX/TVpN7CE+QCUzH7Wdk/Ldwba72sSqub+nA1fabL4j9dAk3
         i8XztMonolO18RN5HZ2UeH6pVnZGBGA1W3oyMUtE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.217.61]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MHoRK-1kuvxh3ba2-00Eqyd; Thu, 17
 Dec 2020 17:21:03 +0100
Message-ID: <1f88b926bedcad0d6e35c7f5b63bbb038c8c6c09.camel@gmx.de>
Subject: [bisected] Re: drm, qxl: post 5.11 merge warning+explosion
From:   Mike Galbraith <efault@gmx.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Dave Airlie <airlied@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Date:   Thu, 17 Dec 2020 17:21:02 +0100
In-Reply-To: <a1b925758cbc5517d4ff6df3cf2a9b6614fd5535.camel@gmx.de>
References: <5979380e28f4ba8023e88f96d3a9291381a8457e.camel@gmx.de>
         <a1b925758cbc5517d4ff6df3cf2a9b6614fd5535.camel@gmx.de>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:B4e418HlYaOUc8nmN7chcWcHDKS1A5mJ5S/7F4mCNxFmJZQUjcG
 MYWKQSMRCUXF7tSkVqSD6Ki0nB0TQFL5lfJFG/zeDQC5jdiZCRZOQxnO1V4IkhlP0mnlHqD
 KC6llOrJU5LRgSBYYlfrLaXLkxu9xA9BD+Guy4FlWV3e/pD11CuL/cdv1gu3AcCos12dRl8
 WN6amfq6WtBUTnRVLk00Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:9aAL17RVKKc=:goWWGf7q4OntYZHTZPfzJ4
 gZ7gGgNoYYogdD/nTqRZ2rfO2LPeGB4y8xSIJCP+kGHSwMNiYftDuzHbDyxG7cUllJphAbPDJ
 1I13ylX0JvaoHMXUZBz6+UtBCCMTUf7+4MoD1hseh/10/L4CLzttWADYlkj89CsbNgVsEA6VC
 H/gJokcy4O4wKE75tFLlo7HZEBAofN6y9I/0LUln93cjmaecNF9CNX/3uyhHfbJLRXTdvBvd7
 St/lBmh9RU6L080WQm1+C6sQy0n8mJfpW/IwdkY1nNgNdjW4Mo6HC3j3+diyHDtjejTfyB4FI
 T0twKBvpuE/7aBfe2HY0aID+P9hj95GhEZaKWmDMUPsRpcUNJH4lGgPpcJ1iVqhCWSq987ea9
 qd9zOervarJviDh02iOJsKiowmOj9D/+26N1DhTLIBwRqaGPxNXin5RUnpd5WgRJcb33pVNiN
 gDRWYUEH6MKybvaNAOQQeyj9ms10s/9gbpmHS1xjVUsSjJh8fVV/Xs2G+urXemsBuM6E5cj5R
 IdIyxYtuROKoBjaYNzqTKgrEufYLiNr90ZCUWTQhs4dpGMlOWBS7yfEkzs5xKbU1MOyCmVBls
 1fM3SKgMbdGB2M4z98T3s8ltNvi1xprsF8jJrtxnFHCVEv4RhpTZu7+5mq9R2JweCCbDrRxtA
 iIC60NsyF+FAl+iYFyhiFDvgge6U3lgG+udjFeGnDl0VXnmKWcFV/yyMLTCSdWrPNJCxxu9Ie
 yvAWJYZOLMr0tPUDlAddW3B/ecIBERZjdVuPCV8BNiVukHtLx0NCLGOBULXubJVFVZOqoUmx9
 rBB5SCTT4QYrj+OJ97tSHJiAdqQ1uMiH2pCsVKv7LBMkA3PeC009Hl5hLWkO2CHXiZtlMkvcc
 ODYhpc5n+lIaqdrUISRQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ee5d2a8e549e90325fcc31825269f89647cd6fac is the first bad commit
commit ee5d2a8e549e90325fcc31825269f89647cd6fac
Author: Christian K=F6nig <christian.koenig@amd.com>
Date:   Sat Oct 24 13:10:28 2020 +0200

    drm/ttm: wire up the new pool as default one v2

    Provide the necessary parameters by all drivers and use the new pool a=
lloc
    when no driver specific function is provided.

    v2: fix the GEM VRAM helpers

    Signed-off-by: Christian K=F6nig <christian.koenig@amd.com>
    Reviewed-by: Dave Airlie <airlied@redhat.com>
    Reviewed-by: Madhav Chauhan <madhav.chauhan@amd.com>
    Tested-by: Huang Rui <ray.huang@amd.com>
    Link: https://patchwork.freedesktop.org/patch/397081/?series=3D83051&r=
ev=3D1

 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c |  4 ++--
 drivers/gpu/drm/drm_gem_vram_helper.c   |  4 ++--
 drivers/gpu/drm/nouveau/nouveau_ttm.c   | 14 +++++++++-----
 drivers/gpu/drm/qxl/qxl_ttm.c           |  5 ++---
 drivers/gpu/drm/radeon/radeon_ttm.c     |  4 ++--
 drivers/gpu/drm/ttm/ttm_bo.c            |  8 ++++++--
 drivers/gpu/drm/ttm/ttm_memory.c        |  2 +-
 drivers/gpu/drm/ttm/ttm_tt.c            |  5 ++---
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c     |  5 +++--
 include/drm/ttm/ttm_bo_driver.h         | 11 +++++++----
 10 files changed, 36 insertions(+), 26 deletions(-)

git bisect start 'drivers/gpu/drm/qxl'
# good: [2c85ebc57b3e1817b6ce1a6b703928e113a90442] Linux 5.10
git bisect good 2c85ebc57b3e1817b6ce1a6b703928e113a90442
# bad: [accefff5b547a9a1d959c7e76ad539bf2480e78b] Merge tag 'arm-soc-omap-=
genpd-5.11' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
git bisect bad accefff5b547a9a1d959c7e76ad539bf2480e78b
# bad: [d635a69dd4981cc51f90293f5f64268620ed1565] Merge tag 'net-next-5.11=
' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next
git bisect bad d635a69dd4981cc51f90293f5f64268620ed1565
# bad: [0ca2ce81eb8ee30f3ba8ac7967fef9cfbb44dbdb] Merge tag 'arm64-upstrea=
m' of git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux
git bisect bad 0ca2ce81eb8ee30f3ba8ac7967fef9cfbb44dbdb
# bad: [f8aab60422c371425365d386dfd51e0c6c5b1041] drm/amdgpu: Initialise d=
rm_gem_object_funcs for imported BOs
git bisect bad f8aab60422c371425365d386dfd51e0c6c5b1041
# bad: [c0f98d2f8b076bf3e3183aa547395f919c943a14] Merge tag 'drm-misc-next=
-2020-11-05' of git://anongit.freedesktop.org/drm/drm-misc into drm-next
git bisect bad c0f98d2f8b076bf3e3183aa547395f919c943a14
# good: [6a6e5988a2657cd0c91f6f1a3e7d194599248b6d] drm/ttm: replace last m=
ove_notify with delete_mem_notify
git bisect good 6a6e5988a2657cd0c91f6f1a3e7d194599248b6d
# good: [f566fdcd6cc49a9d5b5d782f56e3e7cb243f01b8] drm/i915: Force VT'd wo=
rkarounds when running as a guest OS
git bisect good f566fdcd6cc49a9d5b5d782f56e3e7cb243f01b8
# good: [e76ab2cf21c38331155ea613cdf18582f011c30f] drm/i915: Remove per-pl=
atform IIR HPD masking
git bisect good e76ab2cf21c38331155ea613cdf18582f011c30f
# bad: [268af50f38b1f2199a2e85e38073d7a25c20190c] drm/panfrost: Support ca=
che-coherent integrations
git bisect bad 268af50f38b1f2199a2e85e38073d7a25c20190c
# good: [e000650375b65ff77c5ee852b5086f58c741179e] fbdev/atafb: Remove unu=
sed extern variables
git bisect good e000650375b65ff77c5ee852b5086f58c741179e
# bad: [461619f5c3242aaee9ec3f0b7072719bd86ea207] drm/nouveau: switch to n=
ew allocator
git bisect bad 461619f5c3242aaee9ec3f0b7072719bd86ea207
# good: [d099fc8f540add80f725014fdd4f7f49f3c58911] drm/ttm: new TT backend=
 allocation pool v3
git bisect good d099fc8f540add80f725014fdd4f7f49f3c58911
# bad: [e93b2da9799e5cb97760969f3e1f02a5bdac29fe] drm/amdgpu: switch to ne=
w allocator v2
git bisect bad e93b2da9799e5cb97760969f3e1f02a5bdac29fe
# bad: [ee5d2a8e549e90325fcc31825269f89647cd6fac] drm/ttm: wire up the new=
 pool as default one v2
git bisect bad ee5d2a8e549e90325fcc31825269f89647cd6fac
# first bad commit: [ee5d2a8e549e90325fcc31825269f89647cd6fac] drm/ttm: wi=
re up the new pool as default one v2

