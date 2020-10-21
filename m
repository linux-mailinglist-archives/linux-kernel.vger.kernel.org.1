Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC884294611
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 02:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439680AbgJUAkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 20:40:07 -0400
Received: from mga12.intel.com ([192.55.52.136]:10256 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2411012AbgJUAkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 20:40:06 -0400
IronPort-SDR: y8KpVpYaKTYyM533U/kAK52zQUz6DhfeI9G5kO0VDglIv7HgmQlkoMjwSGiATDRgEET/pC4eb8
 IfU6N7Zafl/g==
X-IronPort-AV: E=McAfee;i="6000,8403,9780"; a="146590409"
X-IronPort-AV: E=Sophos;i="5.77,399,1596524400"; 
   d="gz'50?scan'50,208,50";a="146590409"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2020 17:40:05 -0700
IronPort-SDR: FB/Vl5KxJ0MI0yOPxozpAEljFLeXgKIPrMr4qia1chqtKf3SoqAZAc4ApPMiIA5KbC4e7c3buj
 1zXSWL4msO5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,399,1596524400"; 
   d="gz'50?scan'50,208,50";a="316203876"
Received: from lkp-server02.sh.intel.com (HELO 102063808cc1) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 20 Oct 2020 17:40:03 -0700
Received: from kbuild by 102063808cc1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kV2Ad-00001Z-1L; Wed, 21 Oct 2020 00:40:03 +0000
Date:   Wed, 21 Oct 2020 08:39:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: drivers/usb/isp1760/isp1760-udc.c:270:17: sparse: sparse: incorrect
 type in assignment (different base types)
Message-ID: <202010210804.t0picblc-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MGYHOYXEY6WxJCY8"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c4d6fe7311762f2e03b3c27ad38df7c40c80cc93
commit: 005b73d0dd83c9cb9420a196bea8070cde30ecac m68knommu: __force type casts for raw IO access
date:   3 months ago
config: m68k-randconfig-s031-20201021 (attached as .config)
compiler: m68k-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.3-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=005b73d0dd83c9cb9420a196bea8070cde30ecac
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 005b73d0dd83c9cb9420a196bea8070cde30ecac
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=m68k 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


"sparse warnings: (new ones prefixed by >>)"
   drivers/usb/isp1760/isp1760-udc.c:212:24: sparse: sparse: cast to restricted __le32
   drivers/usb/isp1760/isp1760-udc.c:212:24: sparse: sparse: cast to restricted __le32
   drivers/usb/isp1760/isp1760-udc.c:212:24: sparse: sparse: cast to restricted __le32
   drivers/usb/isp1760/isp1760-udc.c:212:24: sparse: sparse: cast to restricted __le32
   drivers/usb/isp1760/isp1760-udc.c:212:24: sparse: sparse: cast to restricted __le32
   drivers/usb/isp1760/isp1760-udc.c:212:24: sparse: sparse: cast to restricted __le32
   drivers/usb/isp1760/isp1760-udc.c:214:31: sparse: sparse: cast to restricted __le16
   drivers/usb/isp1760/isp1760-udc.c:214:31: sparse: sparse: cast to restricted __le16
   drivers/usb/isp1760/isp1760-udc.c:214:31: sparse: sparse: cast to restricted __le16
   drivers/usb/isp1760/isp1760-udc.c:214:31: sparse: sparse: cast to restricted __le16
   drivers/usb/isp1760/isp1760-udc.c:268:53: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   drivers/usb/isp1760/isp1760-udc.c:268:53: sparse:     expected unsigned int [usertype] val
   drivers/usb/isp1760/isp1760-udc.c:268:53: sparse:     got restricted __le32 [usertype]
>> drivers/usb/isp1760/isp1760-udc.c:270:17: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short volatile [usertype] @@     got restricted __le16 [usertype] @@
>> drivers/usb/isp1760/isp1760-udc.c:270:17: sparse:     expected unsigned short volatile [usertype]
   drivers/usb/isp1760/isp1760-udc.c:270:17: sparse:     got restricted __le16 [usertype]
   drivers/usb/isp1760/isp1760-udc.c:485:9: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short volatile [usertype] @@     got restricted __le16 [usertype] @@
   drivers/usb/isp1760/isp1760-udc.c:485:9: sparse:     expected unsigned short volatile [usertype]
   drivers/usb/isp1760/isp1760-udc.c:485:9: sparse:     got restricted __le16 [usertype]

vim +270 drivers/usb/isp1760/isp1760-udc.c

0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  170  
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  171  /* -----------------------------------------------------------------------------
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  172   * Data Endpoints
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  173   */
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  174  
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  175  /* Called with the UDC spinlock held. */
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  176  static bool isp1760_udc_receive(struct isp1760_ep *ep,
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  177  				struct isp1760_request *req)
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  178  {
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  179  	struct isp1760_udc *udc = ep->udc;
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  180  	unsigned int len;
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  181  	u32 *buf;
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  182  	int i;
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  183  
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  184  	isp1760_udc_select_ep(ep);
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  185  	len = isp1760_udc_read(udc, DC_BUFLEN) & DC_DATACOUNT_MASK;
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  186  
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  187  	dev_dbg(udc->isp->dev, "%s: received %u bytes (%u/%u done)\n",
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  188  		__func__, len, req->req.actual, req->req.length);
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  189  
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  190  	len = min(len, req->req.length - req->req.actual);
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  191  
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  192  	if (!len) {
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  193  		/*
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  194  		 * There's no data to be read from the FIFO, acknowledge the RX
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  195  		 * interrupt by clearing the buffer.
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  196  		 *
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  197  		 * TODO: What if another packet arrives in the meantime ? The
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  198  		 * datasheet doesn't clearly document how this should be
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  199  		 * handled.
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  200  		 */
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  201  		isp1760_udc_write(udc, DC_CTRLFUNC, DC_CLBUF);
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  202  		return false;
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  203  	}
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  204  
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  205  	buf = req->req.buf + req->req.actual;
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  206  
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  207  	/*
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  208  	 * Make sure not to read more than one extra byte, otherwise data from
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  209  	 * the next packet might be removed from the FIFO.
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  210  	 */
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  211  	for (i = len; i > 2; i -= 4, ++buf)
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21 @212  		*buf = le32_to_cpu(isp1760_udc_read(udc, DC_DATAPORT));
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  213  	if (i > 0)
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  214  		*(u16 *)buf = le16_to_cpu(readw(udc->regs + DC_DATAPORT));
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  215  
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  216  	req->req.actual += len;
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  217  
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  218  	/*
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  219  	 * TODO: The short_not_ok flag isn't supported yet, but isn't used by
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  220  	 * any gadget driver either.
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  221  	 */
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  222  
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  223  	dev_dbg(udc->isp->dev,
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  224  		"%s: req %p actual/length %u/%u maxpacket %u packet size %u\n",
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  225  		__func__, req, req->req.actual, req->req.length, ep->maxpacket,
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  226  		len);
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  227  
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  228  	ep->rx_pending = false;
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  229  
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  230  	/*
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  231  	 * Complete the request if all data has been received or if a short
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  232  	 * packet has been received.
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  233  	 */
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  234  	if (req->req.actual == req->req.length || len < ep->maxpacket) {
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  235  		list_del(&req->queue);
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  236  		return true;
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  237  	}
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  238  
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  239  	return false;
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  240  }
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  241  
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  242  static void isp1760_udc_transmit(struct isp1760_ep *ep,
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  243  				 struct isp1760_request *req)
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  244  {
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  245  	struct isp1760_udc *udc = ep->udc;
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  246  	u32 *buf = req->req.buf + req->req.actual;
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  247  	int i;
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  248  
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  249  	req->packet_size = min(req->req.length - req->req.actual,
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  250  			       ep->maxpacket);
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  251  
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  252  	dev_dbg(udc->isp->dev, "%s: transferring %u bytes (%u/%u done)\n",
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  253  		__func__, req->packet_size, req->req.actual,
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  254  		req->req.length);
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  255  
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  256  	__isp1760_udc_select_ep(ep, USB_DIR_IN);
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  257  
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  258  	if (req->packet_size)
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  259  		isp1760_udc_write(udc, DC_BUFLEN, req->packet_size);
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  260  
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  261  	/*
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  262  	 * Make sure not to write more than one extra byte, otherwise extra data
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  263  	 * will stay in the FIFO and will be transmitted during the next control
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  264  	 * request. The endpoint control CLBUF bit is supposed to allow flushing
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  265  	 * the FIFO for this kind of conditions, but doesn't seem to work.
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  266  	 */
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  267  	for (i = req->packet_size; i > 2; i -= 4, ++buf)
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  268  		isp1760_udc_write(udc, DC_DATAPORT, cpu_to_le32(*buf));
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  269  	if (i > 0)
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21 @270  		writew(cpu_to_le16(*(u16 *)buf), udc->regs + DC_DATAPORT);
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  271  
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  272  	if (ep->addr == 0)
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  273  		isp1760_udc_write(udc, DC_CTRLFUNC, DC_DSEN);
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  274  	if (!req->packet_size)
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  275  		isp1760_udc_write(udc, DC_CTRLFUNC, DC_VENDP);
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  276  }
0316ca6319b98e4 drivers/usb/host/isp1760-udc.c Laurent Pinchart 2015-01-21  277  

:::::: The code at line 270 was first introduced by commit
:::::: 0316ca6319b98e485325be98a47d08fed07ead43 usb: isp1760: Add device controller support

:::::: TO: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
:::::: CC: Felipe Balbi <balbi@ti.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--MGYHOYXEY6WxJCY8
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--MGYHOYXEY6WxJCY8--
