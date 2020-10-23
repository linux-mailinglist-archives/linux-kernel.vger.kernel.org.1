Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D31C296B63
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 10:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S460747AbgJWIqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 04:46:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58765 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S460716AbgJWIqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 04:46:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603442809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IvsRKgjhFDjNKl4wjaSNuQA16aODKv6msvHNpoykYLU=;
        b=hVxqUg3E8y71SVH7D6VFNjZ/qAZ77NOLL8TSplTXsR8k9Bt0+irDzV5SeuaxJm7XmBFtvQ
        x8eU+jF+H+DTLBcneMK3KDiE3X2r3FuqUmsIYnZFIs7t+P84TcNAozV8NumwdMXK8qB9c4
        yLe1x9qeOGpPHYNxvvTiIcWwoJ7vIjM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-542-zlbqZ4coNTKhSEB7j4t8WQ-1; Fri, 23 Oct 2020 04:46:38 -0400
X-MC-Unique: zlbqZ4coNTKhSEB7j4t8WQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 880601006702;
        Fri, 23 Oct 2020 08:46:36 +0000 (UTC)
Received: from [10.72.13.85] (ovpn-13-85.pek2.redhat.com [10.72.13.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E4D305B4C3;
        Fri, 23 Oct 2020 08:46:28 +0000 (UTC)
Subject: Re: [PATCH V3 2/3] vhost: vdpa: report iova range
To:     kernel test robot <lkp@intel.com>, mst@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, rob.miller@broadcom.com,
        lingshan.zhu@intel.com, eperezma@redhat.com, lulu@redhat.com,
        shahafs@mellanox.com, hanand@xilinx.com, mhabets@solarflare.com
References: <20201023022454.24402-3-jasowang@redhat.com>
 <202010231319.Ix8DqCWr-lkp@intel.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <2c52262f-c54e-dbb0-c906-e4339595e53b@redhat.com>
Date:   Fri, 23 Oct 2020 16:46:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <202010231319.Ix8DqCWr-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/10/23 下午1:28, kernel test robot wrote:
> Hi Jason,
>
> I love your patch! Perhaps something to improve:
>
> [auto build test WARNING on vhost/linux-next]
> [also build test WARNING on linus/master v5.9 next-20201023]
> [cannot apply to linux/master]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
>
> url:    https://github.com/0day-ci/linux/commits/Jason-Wang/vDPA-API-for-reporting-IOVA-range/20201023-102708
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git linux-next
> config: m68k-randconfig-r034-20201022 (attached as .config)
> compiler: m68k-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # https://github.com/0day-ci/linux/commit/446e7b97838ebf87f1acd61580137716fdad104a
>          git remote add linux-review https://github.com/0day-ci/linux
>          git fetch --no-tags linux-review Jason-Wang/vDPA-API-for-reporting-IOVA-range/20201023-102708
>          git checkout 446e7b97838ebf87f1acd61580137716fdad104a
>          # save the attached .config to linux build tree
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=m68k
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
>     drivers/vhost/vdpa.c: In function 'vhost_vdpa_setup_vq_irq':
>     drivers/vhost/vdpa.c:94:6: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
>        94 |  int ret, irq;
>           |      ^~~
>     drivers/vhost/vdpa.c: In function 'vhost_vdpa_unlocked_ioctl':


This looks like another issue that needs to be fixed.


>>> drivers/vhost/vdpa.c:483:5: warning: this statement may fall through [-Wimplicit-fallthrough=]
>       483 |   r = copy_to_user(featurep, &features, sizeof(features));
>           |   ~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     drivers/vhost/vdpa.c:484:2: note: here
>       484 |  case VHOST_VDPA_GET_IOVA_RANGE:
>           |  ^~~~
>
> vim +483 drivers/vhost/vdpa.c


My bad. V4 is on the road.

Thanks


>
> 4c8cf31885f69e8 Tiwei Bie    2020-03-26  426
> 4c8cf31885f69e8 Tiwei Bie    2020-03-26  427  static long vhost_vdpa_unlocked_ioctl(struct file *filep,
> 4c8cf31885f69e8 Tiwei Bie    2020-03-26  428  				      unsigned int cmd, unsigned long arg)
> 4c8cf31885f69e8 Tiwei Bie    2020-03-26  429  {
> 4c8cf31885f69e8 Tiwei Bie    2020-03-26  430  	struct vhost_vdpa *v = filep->private_data;
> 4c8cf31885f69e8 Tiwei Bie    2020-03-26  431  	struct vhost_dev *d = &v->vdev;
> 4c8cf31885f69e8 Tiwei Bie    2020-03-26  432  	void __user *argp = (void __user *)arg;
> a127c5bbb6a8eee Jason Wang   2020-09-07  433  	u64 __user *featurep = argp;
> a127c5bbb6a8eee Jason Wang   2020-09-07  434  	u64 features;
> 4c8cf31885f69e8 Tiwei Bie    2020-03-26  435  	long r;
> 4c8cf31885f69e8 Tiwei Bie    2020-03-26  436
> a127c5bbb6a8eee Jason Wang   2020-09-07  437  	if (cmd == VHOST_SET_BACKEND_FEATURES) {
> a127c5bbb6a8eee Jason Wang   2020-09-07  438  		r = copy_from_user(&features, featurep, sizeof(features));
> a127c5bbb6a8eee Jason Wang   2020-09-07  439  		if (r)
> a127c5bbb6a8eee Jason Wang   2020-09-07  440  			return r;
> a127c5bbb6a8eee Jason Wang   2020-09-07  441  		if (features & ~VHOST_VDPA_BACKEND_FEATURES)
> a127c5bbb6a8eee Jason Wang   2020-09-07  442  			return -EOPNOTSUPP;
> a127c5bbb6a8eee Jason Wang   2020-09-07  443  		vhost_set_backend_features(&v->vdev, features);
> a127c5bbb6a8eee Jason Wang   2020-09-07  444  		return 0;
> a127c5bbb6a8eee Jason Wang   2020-09-07  445  	}
> a127c5bbb6a8eee Jason Wang   2020-09-07  446
> 4c8cf31885f69e8 Tiwei Bie    2020-03-26  447  	mutex_lock(&d->mutex);
> 4c8cf31885f69e8 Tiwei Bie    2020-03-26  448
> 4c8cf31885f69e8 Tiwei Bie    2020-03-26  449  	switch (cmd) {
> 4c8cf31885f69e8 Tiwei Bie    2020-03-26  450  	case VHOST_VDPA_GET_DEVICE_ID:
> 4c8cf31885f69e8 Tiwei Bie    2020-03-26  451  		r = vhost_vdpa_get_device_id(v, argp);
> 4c8cf31885f69e8 Tiwei Bie    2020-03-26  452  		break;
> 4c8cf31885f69e8 Tiwei Bie    2020-03-26  453  	case VHOST_VDPA_GET_STATUS:
> 4c8cf31885f69e8 Tiwei Bie    2020-03-26  454  		r = vhost_vdpa_get_status(v, argp);
> 4c8cf31885f69e8 Tiwei Bie    2020-03-26  455  		break;
> 4c8cf31885f69e8 Tiwei Bie    2020-03-26  456  	case VHOST_VDPA_SET_STATUS:
> 4c8cf31885f69e8 Tiwei Bie    2020-03-26  457  		r = vhost_vdpa_set_status(v, argp);
> 4c8cf31885f69e8 Tiwei Bie    2020-03-26  458  		break;
> 4c8cf31885f69e8 Tiwei Bie    2020-03-26  459  	case VHOST_VDPA_GET_CONFIG:
> 4c8cf31885f69e8 Tiwei Bie    2020-03-26  460  		r = vhost_vdpa_get_config(v, argp);
> 4c8cf31885f69e8 Tiwei Bie    2020-03-26  461  		break;
> 4c8cf31885f69e8 Tiwei Bie    2020-03-26  462  	case VHOST_VDPA_SET_CONFIG:
> 4c8cf31885f69e8 Tiwei Bie    2020-03-26  463  		r = vhost_vdpa_set_config(v, argp);
> 4c8cf31885f69e8 Tiwei Bie    2020-03-26  464  		break;
> 4c8cf31885f69e8 Tiwei Bie    2020-03-26  465  	case VHOST_GET_FEATURES:
> 4c8cf31885f69e8 Tiwei Bie    2020-03-26  466  		r = vhost_vdpa_get_features(v, argp);
> 4c8cf31885f69e8 Tiwei Bie    2020-03-26  467  		break;
> 4c8cf31885f69e8 Tiwei Bie    2020-03-26  468  	case VHOST_SET_FEATURES:
> 4c8cf31885f69e8 Tiwei Bie    2020-03-26  469  		r = vhost_vdpa_set_features(v, argp);
> 4c8cf31885f69e8 Tiwei Bie    2020-03-26  470  		break;
> 4c8cf31885f69e8 Tiwei Bie    2020-03-26  471  	case VHOST_VDPA_GET_VRING_NUM:
> 4c8cf31885f69e8 Tiwei Bie    2020-03-26  472  		r = vhost_vdpa_get_vring_num(v, argp);
> 4c8cf31885f69e8 Tiwei Bie    2020-03-26  473  		break;
> 4c8cf31885f69e8 Tiwei Bie    2020-03-26  474  	case VHOST_SET_LOG_BASE:
> 4c8cf31885f69e8 Tiwei Bie    2020-03-26  475  	case VHOST_SET_LOG_FD:
> 4c8cf31885f69e8 Tiwei Bie    2020-03-26  476  		r = -ENOIOCTLCMD;
> 4c8cf31885f69e8 Tiwei Bie    2020-03-26  477  		break;
> 776f395004d829b Zhu Lingshan 2020-06-05  478  	case VHOST_VDPA_SET_CONFIG_CALL:
> 776f395004d829b Zhu Lingshan 2020-06-05  479  		r = vhost_vdpa_set_config_call(v, argp);
> 776f395004d829b Zhu Lingshan 2020-06-05  480  		break;
> a127c5bbb6a8eee Jason Wang   2020-09-07  481  	case VHOST_GET_BACKEND_FEATURES:
> a127c5bbb6a8eee Jason Wang   2020-09-07  482  		features = VHOST_VDPA_BACKEND_FEATURES;
> a127c5bbb6a8eee Jason Wang   2020-09-07 @483  		r = copy_to_user(featurep, &features, sizeof(features));
> 446e7b97838ebf8 Jason Wang   2020-10-23  484  	case VHOST_VDPA_GET_IOVA_RANGE:
> 446e7b97838ebf8 Jason Wang   2020-10-23  485  		r = vhost_vdpa_get_iova_range(v, argp);
> a127c5bbb6a8eee Jason Wang   2020-09-07  486  		break;
> 4c8cf31885f69e8 Tiwei Bie    2020-03-26  487  	default:
> 4c8cf31885f69e8 Tiwei Bie    2020-03-26  488  		r = vhost_dev_ioctl(&v->vdev, cmd, argp);
> 4c8cf31885f69e8 Tiwei Bie    2020-03-26  489  		if (r == -ENOIOCTLCMD)
> 4c8cf31885f69e8 Tiwei Bie    2020-03-26  490  			r = vhost_vdpa_vring_ioctl(v, cmd, argp);
> 4c8cf31885f69e8 Tiwei Bie    2020-03-26  491  		break;
> 4c8cf31885f69e8 Tiwei Bie    2020-03-26  492  	}
> 4c8cf31885f69e8 Tiwei Bie    2020-03-26  493
> 4c8cf31885f69e8 Tiwei Bie    2020-03-26  494  	mutex_unlock(&d->mutex);
> 4c8cf31885f69e8 Tiwei Bie    2020-03-26  495  	return r;
> 4c8cf31885f69e8 Tiwei Bie    2020-03-26  496  }
> 4c8cf31885f69e8 Tiwei Bie    2020-03-26  497
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

